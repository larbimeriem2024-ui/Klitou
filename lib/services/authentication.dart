

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Authentication {

  final supabase = Supabase.instance.client;
  final user = Supabase.instance.client.auth.currentUser;

  Future<void> signUp(
  String email,
  String password,
  String name,
  String phonen,
) async {


  try {
    
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
     
    );

   

    if (response.user != null) {
     

     return await supabase.from('profile').insert({
        'user_id': response.user!.id,
        'name': name,
        'email': email,
        'phonen': phonen,
      });

     
    }
  } catch (e, stackTrace) {
    print("ERROR is in here please check this please: $e");
    print(stackTrace);
    rethrow;
  }
}

  Future <void> login (String email, String password)async{

  
      final response = await supabase.auth.signInWithPassword(
      email: email, 
      password: password
      );

      if(response.session != null ){
        
      }
  

   
    
  }
  Future <void> signinWithGoogle()async{
    await supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.flutter://login-callback' );
  }

  Future <void> signinWithFacebook()async{
    await supabase.auth.signInWithOAuth(
      OAuthProvider.facebook
    );
  }

  Future <void> logOut()async{
    await supabase.auth.signOut();
  }

  Future <void> verifyEmailForRestPassword(String email)async{
    await supabase.auth.resetPasswordForEmail(email, 
    redirectTo: kIsWeb? null : 'io.supabase.flutter://login-callback');
    
  }

  Future <void> resetPassword(String newPassword)async{
    await supabase.auth.updateUser(UserAttributes(password: newPassword));
  }



}