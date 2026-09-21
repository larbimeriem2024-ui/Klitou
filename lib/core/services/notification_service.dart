


import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Handles everything related to FCM:
/// - Permission
/// - Token lifecycle
/// - Saving token to Supabase
/// - Receiving messages in all app states
class NotificationService {
  NotificationService(this._supabase);

  final SupabaseClient _supabase;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  StreamSubscription<String>? _tokenRefreshSubscription;
  StreamSubscription<RemoteMessage>? _foregroundSubscription;

  /// Call this once after the user is authenticated.
  Future<void> initialize() async {
    // 1. Request permission
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus != AuthorizationStatus.authorized &&
        settings.authorizationStatus != AuthorizationStatus.provisional) {
      debugPrint('User declined notification permission');
      return;
    }

    // 2. iOS-specific setup
    if (Platform.isIOS) {
      await _messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    // 3. Get and save the current token
    await _saveToken();

    // 4. Listen for token refresh
    _tokenRefreshSubscription = _messaging.onTokenRefresh.listen((token) {
      _saveToken(token: token);
    });

    // 5. Handle foreground messages
    _foregroundSubscription =
        FirebaseMessaging.onMessage.listen(_onForegroundMessage);

    // 6. Handle when user taps a notification (app in background)
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    // 7. Handle when app was terminated and opened via notification
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _onMessageOpenedApp(initialMessage);
    }
  }

  /// Gets the FCM token and upserts it into Supabase.
  Future<void> _saveToken({String? token}) async {
    try {
      final fcmToken = token ?? await _messaging.getToken();
      if (fcmToken == null) return;

      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      await _supabase.from('device_tokens').upsert(
        {
          'user_id': userId,
          'fcm_token': fcmToken,
          'platform': Platform.isIOS ? 'ios' : 'android',
          'last_used_at': DateTime.now().toUtc().toIso8601String(),
        },
        onConflict: 'user_id, fcm_token',
      );

      debugPrint('FCM token saved: $fcmToken');
    } catch (e) {
      debugPrint('Failed to save FCM token: $e');
    }
  }

  /// Called when a notification arrives while the app is in the foreground.
  void _onForegroundMessage(RemoteMessage message) {
    debugPrint('Foreground message received: ${message.messageId}');
    // You can emit this to a stream later so Riverpod can react.
    // For now we just log it.
  }

  /// Called when the user taps a notification.
  void _onMessageOpenedApp(RemoteMessage message) {
    debugPrint('Notification tapped: ${message.data}');
    // Later you will handle deep linking / navigation here
    // or expose this via a stream.
  }

  /// Call this on logout if you want to remove the token.
  Future<void> deleteToken() async {
    try {
      final token = await _messaging.getToken();
      if (token == null) return;

      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      await _supabase
          .from('device_tokens')
          .delete()
          .eq('user_id', userId)
          .eq('fcm_token', token);

      await _messaging.deleteToken();
    } catch (e) {
      debugPrint('Failed to delete FCM token: $e');
    }
  }

  /// Clean up subscriptions
  void dispose() {
    _tokenRefreshSubscription?.cancel();
    _foregroundSubscription?.cancel();
  }
}