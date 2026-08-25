
import 'package:flutter_application_9_klitou/shared/providers/supabase_client_provider.dart';
import 'package:flutter_application_9_klitou/features/meals/models/meal_model.dart';
import 'package:flutter_application_9_klitou/features/meals/repository/meals_repository.dart';
import 'package:flutter_application_9_klitou/features/meals/state/notifiers/meals_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mealsRepositoryProvider = Provider<MealsRepository>((ref) {
  final client = ref.read(supabaseClientProvider);
  return MealsRepository(client: client);
},);


final getMealsProvider = FutureProvider<List<Meal>>((ref) {
  final meals = ref.watch(mealsRepositoryProvider);
  return meals.getMeals();
},);




final filteredMealsProvider = Provider<AsyncValue<List<Meal>>>((ref) {
  final query = ref.watch(searchProvider).toLowerCase();
  final allMeals = ref.watch(allMealsProvider);
  
  return allMeals.whenData((mealList) {
    if(query.isEmpty){
      return  mealList;
    }

    return mealList.where((meal) {
      return meal.title.toLowerCase().contains(query);
    },).toList();

    
  },);

},);