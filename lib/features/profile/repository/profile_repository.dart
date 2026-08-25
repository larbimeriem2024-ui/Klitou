



import 'package:flutter_application_9_klitou/features/profile/model.dart/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepository {
  final SupabaseClient _client;
  ProfileRepository({
    required SupabaseClient client
  }): _client = client;



 
  Future<Profile> getProfile(String userId)async{
    final data = await _client
    .from('profile')
    .select()
    .eq('user_id', userId)
    .single();
    

    return Profile.fromJson(data);
  }
}