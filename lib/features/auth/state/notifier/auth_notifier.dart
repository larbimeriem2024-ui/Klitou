

import 'dart:async';
import 'package:flutter_application_9_klitou/features/auth/models/auth_state.dart';
import 'package:flutter_application_9_klitou/features/auth/state/providers/auth_provider.dart';
import 'package:flutter_application_9_klitou/features/meals/state/providers/meals_provider.dart';
import 'package:flutter_application_9_klitou/features/orders/state/providers/cart_provider.dart';
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


  


  

  Future <void> signInWithGoogle()async{
    state = AsyncLoading();
    state = await AsyncValue.guard(()async{
      
      await ref.read(authRepositoryProvider).signinWithGoogle();
      
      return state.value ?? const AuthUnauthenticated();

    });
  }

  Future <void> signInWithFacebook() async{
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

      ref.invalidate(cartProvider);
      ref.invalidate(getMealsProvider);
      ref.invalidate(preparingOrderProvider);
      ref.invalidate(myDoneOrderProvider);
      return const AuthUnauthenticated();
    });
  }

  


  


}


