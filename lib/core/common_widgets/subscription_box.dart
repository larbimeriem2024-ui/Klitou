import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
class SubscriptionBox extends StatelessWidget {
  final bool isWhite;
  final String status;
  final String image;
  final String title;
  final String price;
  final String period;
  final String s1;
  final String s2;
  final String s3;
  const SubscriptionBox({
    super.key,
    required this.isWhite,
    required this.status,
    required this.image,
    required this.title,
    required this.price,
    required this.period,
    required this.s1,
    required this.s2,
    required this.s3,
  
    
    });

  @override
  Widget build(BuildContext context) {

    var media = MediaQuery.of(context).size;
    return Container(
              width: media.width,
              decoration: BoxDecoration(
                color: isWhite? AppColor.white : AppColor.apptheme,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                      decoration: BoxDecoration(
                        color: isWhite? AppColor.rowbox : AppColor.fieldText,
                        borderRadius: BorderRadius.circular(20)

                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        child: Text(
                          status, 
                          style: TextStyle(
                            color: isWhite? AppColor.description : AppColor.white,
                            fontSize: 14, 
                            fontWeight: FontWeight.w600, 
                            
                          ),
                        ),
                      ),
                     ),
                        Image.asset(
                          image,
                          color: isWhite? AppColor.apptheme : AppColor.white,
                          height: 20,
                          width: 20,
                          )
                      ],
                    ),
                    SizedBox(height: 16,),
                    Text(
                      title, 
                       style: TextStyle(
                        color: isWhite? AppColor.fontColor: AppColor.white,
                        fontSize: 20, 
                        fontWeight: FontWeight.w700,
                       ),
                      
                      ),
                    SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                          price, 
                           style: TextStyle(
                            color:isWhite? AppColor.apptheme : AppColor.white,
                            fontSize: 24, 
                            fontWeight: FontWeight.w700,
                           ),
                          
                          ),

                          SizedBox(width: 5,),

                          Text(
                      '/$period', 
                       style: TextStyle(
                        color: isWhite? AppColor.description : AppColor.fieldText,
                        fontSize: 16, 
                        fontWeight: FontWeight.w400,
                       ),
                      
                      ),
                        ],

                      ),
                    SizedBox(height: 16,), 
                      Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/imgs/true.png',
                                color: isWhite? AppColor.apptheme: AppColor.white,
                                height: 16,
                                width: 16,
                                ),
                              SizedBox(width: 8,),
                              Text(
                                s1,
                                style: TextStyle(
                                  color: isWhite? AppColor.description : AppColor.white,
                                  fontSize: 16, 
                                  fontWeight: FontWeight.w400,
                                ),
                                ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Image.asset(
                                'assets/imgs/pdelivery.png',
                                color: isWhite? AppColor.apptheme: AppColor.white,
                                height: 16,
                                width: 16,
                                ),
                              SizedBox(width: 8,),
                              Text(
                                s2,
                                style: TextStyle(
                                  color: isWhite? AppColor.description : AppColor.white,
                                  fontSize: 16, 
                                  fontWeight: FontWeight.w400,
                                ),
                                ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Image.asset(
                                'assets/imgs/true.png',
                                color: isWhite? AppColor.apptheme: AppColor.white,
                                height: 16,
                                width: 16,
                                ),
                              SizedBox(width: 8,),
                              Text(
                                s3,
                                style: TextStyle(
                                  color: isWhite? AppColor.description : AppColor.white,
                                  fontSize: 16, 
                                  fontWeight: FontWeight.w400,
                                ),
                                ),
                            ],
                          ),
                        
                        ],

                      ),

                      SizedBox(height: 32,),

                      GestureDetector(
                        onTap: () {
                          
                        },

                        child: Container(
                          width: media.width,
                          decoration: BoxDecoration(
                            color: isWhite? AppColor.apptheme : AppColor.white, 
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: Text(
                                'Subscribe Now',
                                style: TextStyle(
                                  color: isWhite? AppColor.backgroundColor: AppColor.apptheme,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                              
                              
                                ),
                                ),
                            ),
                          ),
                        ),
                      )

                  
                  
                  
                  
                  ],


                ),
              ),
            );
  }
}