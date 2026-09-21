import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/meals/widgets/all_available_meals.dart';
import 'package:flutter_application_9_klitou/features/meals/widgets/explore_dishes.dart';
import 'package:flutter_application_9_klitou/features/meals/widgets/meals_category.dart';
import 'package:flutter_application_9_klitou/features/meals/widgets/search_for_meals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';







class MenuPage extends ConsumerStatefulWidget {
  const MenuPage({super.key});

  @override
  ConsumerState<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends ConsumerState<MenuPage> {
  
  

  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 8),

              SearchForMeals(),

              SizedBox(height: 32),
              
              MealsCategory(),

              SizedBox(height: 32,),
              
          
                ExploreDishes(),
              SizedBox(height: 32,),
              AllAvailableMeals(),
          
    
            ],
          ),
        ),
      ),
    );
  }
}
