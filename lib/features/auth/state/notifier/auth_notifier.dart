

import 'dart:async';
import 'package:flutter_application_9_klitou/features/auth/models/auth_state.dart';
import 'package:flutter_application_9_klitou/features/auth/state/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends AsyncNotifier<AuthState>{
  @override
  Future<AuthState> build() async{
    final authRepo = ref.watch(authRepositoryProvider);

    

    final subscription = authRepo.authStateChanges.listen((authState) {
      state = AsyncData(authState);
    });
    ref.onDispose(() => subscription.cancel());
    return authRepo.currentAuthState;
  }

  Future <void> signup({
    required String email, 
    required String password, 
    required String name,
    required String phone

  })async{
    state = AsyncLoading();
    state = await AsyncValue.guard(()async{
      final user = await ref.read(authRepositoryProvider).signUp(email, password, name, phone);
      return AuthAuthenticated(user);
      
    });

    

  }


  Future <void> login({
    required String email, 
    required String password,

  }) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(()async{
      await ref.read(authRepositoryProvider).login(email: email, password: password);
      return state.value ?? const AuthUnauthenticated();

    }); 
  }

  Future <void> signInWithGoogle()async{
    state = AsyncLoading();
    state = await AsyncValue.guard(()async{
      print('Starting Google signin');
      await ref.read(authRepositoryProvider).signinWithGoogle();
      print('Google signInWithOAth finished');
      return state.value ?? const AuthUnauthenticated();

    });
  }

  Future <void> signInWithFacebook()async{
    state = AsyncLoading();
    state = await AsyncValue.guard(()async{
      await ref.read(authRepositoryProvider).signinWithFacebook();
      return state.value ?? const AuthUnauthenticated();
    });
  }

  Future <void> logout()async{
    state = AsyncLoading();
    state = await AsyncValue.guard(()async{
      await ref.read(authRepositoryProvider).logOut();

      return const AuthUnauthenticated();
    });
  }

  Future <void> verifyEmailForRestPassword(
     String email,
  )async{
    state = AsyncLoading();
    state = await AsyncValue.guard(()async{
      await ref.read(authRepositoryProvider).verifyEmailForRestPassword(email);
      return state.value ?? const AuthUnauthenticated();
    });
  }

  Future <void> resetPassword (
    String newPassword
  )async{
    state = AsyncLoading();
    state = await AsyncValue.guard(()async{
      await ref.read(authRepositoryProvider).resetPassword(newPassword);
      return state.value ?? const AuthUnauthenticated();

    });
  }


}

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

