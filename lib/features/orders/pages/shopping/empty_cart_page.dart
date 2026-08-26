import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/big_title.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/button.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/view_all.dart';
import 'package:flutter_application_9_klitou/features/meals/state/notifiers/meals_notifier.dart';
import 'package:flutter_application_9_klitou/features/meals/widgets/recommended_meals.dart';
import 'package:flutter_application_9_klitou/features/orders/pages/order_meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmptyCartPage extends ConsumerStatefulWidget {
  final VoidCallback exploreDishes;

  const EmptyCartPage({super.key, required this.exploreDishes});
  

  @override
  ConsumerState<EmptyCartPage> createState() => _EmptyCartPageState();
}

class _EmptyCartPageState extends ConsumerState<EmptyCartPage> {
  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(allMealsProvider);
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          
        
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
          ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BigTitle(title: 'Your Cart is Empty'),
                  SizedBox(height: 8),
                  Text(
                    'looks like you didnt add anything yet.\n explore delicious meals and add them to your cart.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.description,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 16),
                  Button(
                    onClicked: widget.exploreDishes,
                    color: AppColor.apptheme,
                    title: 'Browse Dishes',
                    fontColor: AppColor.white,
                    isborder: false,
                  ),
                  SizedBox(height: 16,),
                        
                  Button(
                    onClicked: () {
                      
                    }, 
                    color: AppColor.backgroundColor, 
                    title: 'View Past Orders', 
                    fontColor: AppColor.apptheme, 
                    isborder: false),
                        
                  SizedBox(height: 32,),
                        
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                    children: [
                      Text(
                        'Recommended for you ',
                        style: TextStyle(
                          color: AppColor.fontColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                        
                      ViewAll(onPressed: widget.exploreDishes),
                        
                      
                    ],
                  ),

                  meals.when(
                data: (meals) {
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        var dish = meals[index];
                        return RecommendedMeals(
                          
                        meal: dish ,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderMeal(meal: dish),));
                          
                        },);
                      }, ),
                  );
                }, 
                error: (error, stackTrace) {
                  return Text('Error: $error'); 
                  },
                loading: (){
                   return CircularProgressIndicator();})
                  
                        
               
               
               
               
               
               
               
                ],
                        
                        
              ),
            ),
          ),
        );
        }
      ),
    );
  }
}
