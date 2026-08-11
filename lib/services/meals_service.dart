
import 'package:supabase_flutter/supabase_flutter.dart';

class MealsService {
  final supabase= Supabase.instance.client;
  static Future <List<Map<String, dynamic>>> getMeals()async{
    final supabase = Supabase.instance.client;
    final data = await supabase.from('meals').select();
    return List<Map<String, dynamic>>.from(data);


  }

  Future <List<dynamic>> searchMeals(String query)async{
    

    return await supabase
    .from('meals')
    .select()
    .ilike('name', '%$query%');
  }


  
}