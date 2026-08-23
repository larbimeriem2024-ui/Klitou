

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient client;
  AuthRepository({
    required this.client
  });

  
  final user = Supabase.instance.client.auth.currentUser;

  Future<User?> signUp(
  String email,
  String password,
  String name,
  String phonen,
) async {


 
    
    final response =  await client.auth.signUp(
      email: email,
      password: password,
     
    );

    return response.user;

   

    
}

  Future <void> login (String email, String password)async{

  
      final response = await client.auth.signInWithPassword(
      email: email, 
      password: password
      );

      if(response.session != null ){
        
      }
  

   
    
  }
  Future <void> signinWithGoogle()async{
    await client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.flutter://login-callback' );
  }

  Future <void> signinWithFacebook()async{
    await client.auth.signInWithOAuth(
      OAuthProvider.facebook
    );
  }

  Future <void> logOut()async{
    await client.auth.signOut();
  }

  Future <void> verifyEmailForRestPassword(String email)async{
    await client.auth.resetPasswordForEmail(email, 
    redirectTo: kIsWeb? null : 'io.supabase.flutter://login-callback');
    
  }

  Future <void> resetPassword(String newPassword)async{
    await client.auth.updateUser(UserAttributes(password: newPassword));
  }



}