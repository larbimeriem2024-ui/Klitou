

import 'dart:async';

import 'package:flutter_application_9_klitou/features/meals/models/meal_model.dart';
import 'package:flutter_application_9_klitou/features/meals/state/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealsNotifier extends AsyncNotifier<List<Meal>>  {

  @override
  FutureOr<List<Meal>> build() async{
    final meals = await ref.watch(getMealsProvider).value ?? [];

    return meals;
    
  }


}

final allMealsProvider = AsyncNotifierProvider<MealsNotifier, List<Meal>>(MealsNotifier.new);



class SearchNotifier extends Notifier<String> {
  @override
  String build() => '';

  void updateQuery(String query) {
    state = query;
  }
  void clear(){
    state = '';
  }
}

final searchProvider =
    NotifierProvider<SearchNotifier, String>(SearchNotifier.new);