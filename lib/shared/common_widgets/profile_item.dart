


import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:go_router/go_router.dart';




class ProfileItem extends StatelessWidget {
  final String image;
  final String title;
  final String thePage;
  const ProfileItem({super.key, required this.image, required this.title, required this.thePage});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        context.push(thePage);
      },
      child: Container(
        height: 72,
        width: media.width ,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
          
      
        ),
      
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.fieldBg,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(
                        image,
                        height: 25,
                        width: 25,
                        ),
                    ),
                  ),
      
                    SizedBox(width: 16,),
                  
              Text(title,
              style: TextStyle(
                color: AppColor.fontColor, 
                fontSize: 16, 
                fontWeight: FontWeight.w700,
              ),)
                ],
              ), 
          
              Image.asset(
                'assets/imgs/arrow.png',
                height: 16,
                width: 16,
                )
          
            ],
          ),
        ),
      ),
    );
  }
}