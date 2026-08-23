
import 'package:flutter_application_9_klitou/features/meals/models/meal_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MealsRepository {
  final SupabaseClient client;
  MealsRepository({
    required  this.client
  });
   
   Future<List<Meal>> getMeals() async{
    final data = await client
    .from('meals')
    .select();


    return data.map((meal){
      return Meal.fromJson(meal);
      }
      ).toList(); 




  }

 


  
}