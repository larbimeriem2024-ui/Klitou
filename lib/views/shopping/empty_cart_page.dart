import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/common/app_color.dart';
import 'package:flutter_application_9_klitou/common_widgets/big_title.dart';
import 'package:flutter_application_9_klitou/common_widgets/button.dart';
import 'package:flutter_application_9_klitou/common_widgets/recommended_meals.dart';
import 'package:flutter_application_9_klitou/common_widgets/view_all.dart';
import 'package:flutter_application_9_klitou/services/meals_service.dart';
import 'package:flutter_application_9_klitou/views/menu/order_meal.dart';

class EmptyCartPage extends StatefulWidget {
  final VoidCallback exploreDishes;

  const EmptyCartPage({super.key, required this.exploreDishes});
  

  @override
  State<EmptyCartPage> createState() => _EmptyCartPageState();
}

class _EmptyCartPageState extends State<EmptyCartPage> {
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
                  SizedBox(
                        height: 200,
                        child: FutureBuilder<List<Map<String, dynamic>>>(
                                        future: MealsService.getMeals(),
                                        builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        
                        final dishes = snapshot.data ?? [];
                        
                        return ListView.builder(
                          
                          scrollDirection: Axis.horizontal,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            
                            final dish = dishes[index];
                        
                            return RecommendedMeals(
                              image: dish['image_url'],
                              name: dish['name'],
                              price: dish['price'].toString(),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderMeal(
                                      image: dish['image_url'],
                                      title: dish['name'],
                                      rank: dish['rating'],
                                      id: dish['id'],
                                      price: dish['price'],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                                        },
                                      ),
                      ),
                        
               
               
               
               
               
               
               
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
