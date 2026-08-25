

import 'package:flutter/foundation.dart';
import 'package:flutter_application_9_klitou/features/auth/models/auth_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

class AuthRepository {
  final SupabaseClient _client;
  AuthRepository({
    required SupabaseClient client
  }): _client = client ;

  Stream<AuthState> get authStateChanges {
    return _client.auth.onAuthStateChange.map((data) {
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


  Future<User> signUp(
  String email,
  String password,
  String name,
  String phonen,
) async {
    
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
      throw const AuthException('Singup failed. please try again. ');
    }

    await _client.from('profile').insert({
        'user_id': user.id,
        'name': name,
        'email': email,
        'phonen': phonen,
      });

    



    return user;

   

    
}

  Future <void> login ({
    required String email,
    required String password}
    )async{

     await _client.auth.signInWithPassword(
      email: email, 
      password: password
      );

     
  

   
    
  }
  Future <void> signinWithGoogle()async{
    await _client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.flutter://login-callback' );
  }

  Future <void> signinWithFacebook()async{
    await _client.auth.signInWithOAuth(
      OAuthProvider.facebook
    );
  }

  Future <void> logOut()async{
    await _client.auth.signOut();
  }

  Future <void> verifyEmailForRestPassword(String email)async{
    await _client.auth.resetPasswordForEmail(email, 
    redirectTo: kIsWeb? null : 'io.supabase.flutter://login-callback');
    
  }

  Future <void> resetPassword(String newPassword)async{
    await _client.auth.updateUser(UserAttributes(password: newPassword));
  }



}

