import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/common/app_color.dart';
import 'package:flutter_application_9_klitou/common_widgets/description_text.dart';


class MyOrdersDish extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final int quantity;
  final DateTime date;
  final int index;
  final bool isInProgress;
  const MyOrdersDish({
    super.key, 
    required this.image,
    required this.title,
    required this.price,
    required this.quantity,
    required this.date,
    required this.index,
    required this.isInProgress
  
  
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      height: 135,
      width: media.width,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(15),
       
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(15),
              child: Image.network(
                image,
                width: (media.width / 2) - 60,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
        
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: AppColor.fontColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                     Container(
                      decoration: BoxDecoration(
                        color: isInProgress? AppColor.fieldBg : AppColor.rowbox,
                        borderRadius: BorderRadius.circular(20)

                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        child: Text(
                          isInProgress?'Preparing': 'Delivered', 
                          style: TextStyle(
                            color:isInProgress? AppColor.apptheme : AppColor.description,
                            fontSize: 14, 
                            fontWeight: FontWeight.w600, 
                            
                          ),
                        ),
                      ),
                     )
                    ],
                  ),
                  
                  Expanded(child: SizedBox()),

                  Row(
                    children: [
                      Image.asset(
                        'assets/imgs/watch.png',
                        height: 16,
                        width: 16,
                        ),
                  
                      SizedBox(width: 5,), 
                      DescriptionText(title: date.toString().split('.').first.substring(0,16)),
                  
                       
                    ],
                  ),
                   
                   Expanded(child: SizedBox()),
                   
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                        '$price DZ',
                        style: TextStyle(
                          color: AppColor.apptheme,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                                         ),
                                     Column(
  children: [
    if (isInProgress == false)
      GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.apptheme, 
            borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              'Reorder',
              style: TextStyle(
                color: AppColor.backgroundColor,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
  ],
),
                     ],
                   ),
                  
                   
                                    
                  
                 
                  
                      
                  
                 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}