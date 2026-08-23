

import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepository {
  final SupabaseClient client;
  ProfileRepository({
    required this.client
  });
  

  Future <void> createProfile({
    required String userId,
    required String name, 
    required String email, 
    required String phone,

  })async{
   await client.from('profile').insert({
        'user_id': userId,
        'name': name,
        'email': email,
        'phonen': phone,
      });
  }
}