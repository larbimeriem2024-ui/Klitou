
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_9_klitou/features/auth/errors/auth_failure.dart';
import 'package:flutter_application_9_klitou/features/auth/models/auth_state.dart';
import 'package:flutter_application_9_klitou/features/auth/models/signup_result.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

class AuthRepository {
  final SupabaseClient _client;
  AuthRepository({
    required SupabaseClient client
  }): _client = client ;

  Stream<AuthState> get authStateChanges {
    return _client.auth.onAuthStateChange.map((data) {
       if (data.event == AuthChangeEvent.passwordRecovery) {
      return const AuthPasswordRecovery();
    }
      final session = data.session;
      if (session != null) {
        return AuthAuthenticated(session.user);
      }
      return const AuthUnauthenticated();
    });
  }

  AuthState get currentAuthState {
  final session = _client.auth.currentSession;

  if (session != null) {
    return AuthAuthenticated(session.user);
  }

  return const AuthUnauthenticated();
}


  Future<SignupResult> signUp(
  String email,
  String password,
  String name,
  String phonen,
) async {
    try{
    final response =  await _client.auth.signUp(
      email: email,
      password: password,
      data: {
        'name': name,
        'phone':phonen
      }
     
    );

    final user = response.user;
    if(user == null){
      throw const UnknownAuthFailure();
    }

    

      if (response.session != null ){
        return const SignupAuthenticated();
      }

    



    return const SignupEmailVerificationRequired();

   
    }on AuthException catch(error){
      throw _mapAuthException(error);
    }on SocketException{
      throw const NetworkFailure();
    }
}

  Future <void> login ({
    required String email,
    required String password}
    )async{
      try{

     await _client.auth.signInWithPassword(
      email: email, 
      password: password
      );
      } on AuthException catch(error){
        throw _mapAuthException(error);
      } on Exception {
        throw const NetworkFailure();
      } catch(_){
        throw const UnknownAuthFailure();
      }
     
  

   
    
  }
  Future <void> signinWithGoogle()async{
    await _client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: kIsWeb
      ? 'https://klitou-3e9a8.web.app'
      : 'io.supabase.flutter://login-callback' );
  }

  Future <void> signinWithFacebook()async{
    await _client.auth.signInWithOAuth(
      OAuthProvider.facebook
    );
  }

  Future <void> logOut()async{
    await _client.auth.signOut();
  }

  

  Future <void> resetPassword(String newPassword)async{
    await _client.auth.updateUser(UserAttributes(password: newPassword));
  }

  Future<void> verifyEmailForRestPassword(String email) async {
    try{
      await _client.auth.resetPasswordForEmail(
        email, 
        redirectTo: kIsWeb 
        ? 'https://klitou-3e9a8.web.app/resetpassword'
        : 'io.supabase.flutter://reset-password-callback');
    }on AuthException catch (error){
      throw _mapAuthException(error);
    }
  }



}

AuthFailure _mapAuthException(AuthException error) {
  switch (error.code) {
    case 'user_already_exists':
      return const EmailAlreadyRegistered();

    case 'invalid_credentials':
      return const InvalidCredentials();

    case 'invalid_email':
      return const InvalidEmail();

    case 'weak_password':
      return const WeakPassword();

    default:
      return const UnknownAuthFailure();
  }
}