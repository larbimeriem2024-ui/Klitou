


import 'package:flutter_application_9_klitou/shared/providers/supabase_client_provider.dart';
import 'package:flutter_application_9_klitou/features/auth/models/auth_state.dart';
import 'package:flutter_application_9_klitou/features/auth/repository/auth_repository.dart';
import 'package:flutter_application_9_klitou/features/auth/state/notifier/auth_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

final authRepositoryProvider = Provider<AuthRepository>((ref){
  final client = ref.read(supabaseClientProvider);
  return AuthRepository(client: client);

});

// this is for auth state : authenticated , unauthenticated, error , loading ...
final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);


// u can find the current user access to auth of supabase
final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authNotifierProvider).value;

  if (authState is AuthAuthenticated) {
    return authState.user;
  }
  return null;
});


// the user is signedin or not true or false
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(currentUserProvider) != null;
});



