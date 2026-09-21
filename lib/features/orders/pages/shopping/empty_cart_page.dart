import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/orders/widget/meals_recommendations.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/big_title.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EmptyCartPage extends ConsumerStatefulWidget {
  

  const EmptyCartPage({super.key, });
  

  @override
  ConsumerState<EmptyCartPage> createState() => _EmptyCartPageState();
}

class _EmptyCartPageState extends ConsumerState<EmptyCartPage> {
  @override
  Widget build(BuildContext context) {
   
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
                    onClicked: () {
                    context.go('/menu');
                    },
                    color: AppColor.apptheme,
                    title: 'Browse Dishes',
                    fontColor: AppColor.white,
                    isborder: false,
                  ),
                  SizedBox(height: 16,),
                        
                  Button(
                    onClicked: () {
                      context.push('/orders');
                    }, 
                    color: AppColor.backgroundColor, 
                    title: 'View Past Orders', 
                    fontColor: AppColor.apptheme, 
                    isborder: false),
                        
                  SizedBox(height: 32,),
                        
                  MealsRecommendations(),
                  
                        
               
               
               
               
               
               
               
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
