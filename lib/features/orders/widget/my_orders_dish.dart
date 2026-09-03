import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/orders/models/my_order_model.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/description_text.dart';


class MyOrdersDish extends StatelessWidget {
  final MyOrder order;
  final bool isInProgress;
  const MyOrdersDish({
    super.key, 
    
    required this.order,
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
                order.meal.image,
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
                        order.meal.title,
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
                      DescriptionText(title: (order.deliveryDate).toString().split('.').first.substring(0,16)),
                  
                       
                    ],
                  ),
                   
                   Expanded(child: SizedBox()),
                   
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                        '${order.price} DZ',
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