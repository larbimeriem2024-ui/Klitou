

import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/meals/widgets/all_available_meals.dart';
import 'package:flutter_application_9_klitou/features/meals/widgets/explore_dishes.dart';
import 'package:flutter_application_9_klitou/features/meals/widgets/meals_category.dart';
import 'package:flutter_application_9_klitou/features/meals/widgets/profile_header.dart';
import 'package:flutter_application_9_klitou/features/meals/widgets/search_for_meals.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/description_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key,});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
 
 
  
  
  final TextEditingController mealSearchController = TextEditingController();  
  @override
  Widget build(BuildContext context) {
    
   
    
    

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),

              ProfileHeader(),

             

              SizedBox(height: 2),
              DescriptionText(title: 'Ready for your next study session meal?'),

              SizedBox(height: 32),

              SearchForMeals(),
              SizedBox(height: 32),
              
              MealsCategory(),

              SizedBox(height: 32,),

             ExploreDishes(),

              SizedBox(height: 32),

              AllAvailableMeals(),
 
       
                
            ],
          ),
        ),
      ),
    );
  }
}
