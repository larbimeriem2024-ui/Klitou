
import 'package:supabase_flutter/supabase_flutter.dart';


 class ProfileService {

  static String? name;
  static String? email;
  static String? phonen;

  
  

  static Future<void> loadProfile() async{
    
   final user = Supabase.instance.client.auth.currentUser;
  if (user == null) {
    throw Exception('No logged-in user found');
  }
    final data = await Supabase.instance.client.from('profile').select().eq('user_id', user.id).single();

  name = data['name'];
    email = data['email'];
    phonen = data['phonen'];
}}



  