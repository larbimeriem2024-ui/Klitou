

import 'package:flutter_application_9_klitou/core/services/notification_service.dart';
import 'package:flutter_application_9_klitou/features/auth/state/providers/auth_provider.dart';
import 'package:flutter_application_9_klitou/shared/providers/supabase_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


final notificationServiceProvider = Provider<NotificationService>((ref) {
  final supabaseclient = ref.read(supabaseClientProvider);
  return NotificationService(supabaseclient);
},);


final notificationAuthListenerProvider = Provider<void>((ref) {
  ref.listen<User?>(currentUserProvider, (previous, next) {
    if (next != null) {
      ref.read(notificationServiceProvider).initialize();
    }
  });
});



