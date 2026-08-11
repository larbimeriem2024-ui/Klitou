

import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/common/app_color.dart';
class RecommendedMeals extends StatefulWidget {
   final String image;
  final String name;
  final String price;
  final VoidCallback onTap;
  const RecommendedMeals({super.key,required this.image, required this.name, required this.price, required this.onTap});

  @override
  State<RecommendedMeals> createState() => _RecommendedMealsState();
}

class _RecommendedMealsState extends State<RecommendedMeals> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.all(8),
        height: 160,
        width: (media.width / 2 ) - 30 ,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(20),
       
          
        ),
      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(15),
                  child: Image.network(
                    widget.image,
                    width: media.width,
                    height: 90,
                    
                    fit: BoxFit.cover ,
                    
                    ),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name, 
                        style: TextStyle(
                          color: AppColor.fontColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                    
                        ),),
                      Row(
                        children: [
                          Text(
                            widget.price, 
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
                  
                    
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}