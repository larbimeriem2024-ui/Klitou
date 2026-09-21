import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/features/meals/state/providers/meals_provider.dart';
import 'package:flutter_application_9_klitou/features/meals/widgets/dish_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AllAvailableMeals extends ConsumerStatefulWidget {
  const AllAvailableMeals({super.key});

  @override
  ConsumerState<AllAvailableMeals> createState() => _AllAvailableMealsState();
}

class _AllAvailableMealsState extends ConsumerState<AllAvailableMeals> {
  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(filteredMealsProvider);
    return meals.when(
                data: (meals) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: meals.length,
                    itemBuilder: (context, index) {
                      var dish = meals[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: DishView(
                          
                        meal: dish ,
                        onTap: () {
                          context.push('/order-meal', extra: dish);
                          
                        },),
                      );
                    }, );
                }, 
                error: (error, stackTrace) {
                  return Text('Error: $error'); 
                  },
                loading: (){
                   return CircularProgressIndicator();});
  }
}