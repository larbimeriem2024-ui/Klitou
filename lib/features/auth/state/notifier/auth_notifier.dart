

import 'dart:async';

import 'package:flutter_application_9_klitou/features/auth/state/providers/auth_provider.dart';
import 'package:flutter_application_9_klitou/features/auth/state/providers/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends AsyncNotifier<void>{
  @override
  Future<void> build() async{}

  Future <void> signup({
    required String email, 
    required String password, 
    required String name,
    required String phone

  })async{
    state = AsyncLoading();
    state = await AsyncValue.guard(()async{
      final user = await ref.read(authProvider).signUp(email, password, name, phone);

      if(user == null){
        throw Exception('user was not created');
      }
      print("user created : ${user.id}");

      await ref.read(profileProvider).createProfile(userId: user.id, name: name, email: email, phone: phone);
      
    });
    print('Profile created');

    

  }


  Future <void> login({
    required String email, 
    required String password,

  }) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(()async{
      await ref.read(authProvider).login(email, password);

    }); 
  }

  Future <void> signInWithGoogle()async{
    state = AsyncLoading();
    state = await AsyncValue.guard(()async{
      await ref.read(authProvider).signinWithGoogle();

    });
  }

  Future <void> signInWithFacebook()async{
    state = AsyncLoading();
    state = await AsyncValue.guard(()async{
      await ref.read(authProvider).signinWithFacebook();
    });
  }

  Future <void> logout()async{
    state = AsyncLoading();
    state = await AsyncValue.guard(()async{
      await ref.read(authProvider).logOut();
    });
  }

  Future <void> verifyEmailForRestPassword(
     String email,
  )async{
    state = AsyncLoading();
    state = await AsyncValue.guard(()async{
      await ref.read(authProvider).verifyEmailForRestPassword(email);
    });
  }

  Future <void> resetPassword (
    String newPassword
  )async{
    state = AsyncLoading();
    state = await AsyncValue.guard(()async{
      await ref.read(authProvider).resetPassword(newPassword);

    });
  }


}

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, void>(AuthNotifier.new);

