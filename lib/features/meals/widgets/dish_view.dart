import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/meals/models/meal_model.dart';


class DishView extends StatelessWidget {
 final Meal meal;
 final VoidCallback onTap;
  const DishView({super.key, required this.meal, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        
        height: 280,
        width: media.width,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(20),
       
          
        ),
      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Stack(
                
                children: [ 
                Image.network(
                  meal.image,
                  height: 190,
                  width: media.width,
                  fit: BoxFit.cover ,
                  
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Container(
                      width: 66,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColor.backgroundColor,
                        borderRadius: BorderRadius.circular(20)
                    
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                        
                          children: [
                            Image.asset('assets/imgs/star.png',
                            height: 20,
                            width: 20,
                            ),
                            SizedBox(width: 3,),
                            Text((meal.rate).toString(), 
                            style: TextStyle(
                              color: AppColor.fontColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                            ),),
                          ],
                        ),
                      ),
                    ),
                  )
                ]
              ),
            ),
            SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.title, 
                        style: TextStyle(
                          color: AppColor.fontColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w600
                    
                        ),),
                      Row(
                        children: [
                          Text(
                            (meal.price).toString(), 
                            style: TextStyle(
                              color: AppColor.apptheme,
                              fontSize: 16,
                              fontWeight: FontWeight.w700
                          
                          
                            ),),
      
                            SizedBox(width: 5,),
      
                            Text(
                              'DZ',
                              style: TextStyle(
                                color: AppColor.description,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
      
      
                              ),
                              
                              )
                        ],
                      )
                    ],
                  ), 
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: AppColor.apptheme,
                      borderRadius: BorderRadius.circular(15),
                    ),
      
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset('assets/imgs/plus.png'),
                    ),
                  )
                    
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}