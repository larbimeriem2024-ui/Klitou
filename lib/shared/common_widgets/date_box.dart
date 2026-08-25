import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';


class DateBox extends StatelessWidget {
  final String dayName;
  final String dayDate;
  final bool isSelected;
  final VoidCallback onTap;
  const DateBox({super.key, required this.dayName, required this.dayDate, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                                            onTap: onTap,
                                            child: Container(
                                              height: 100,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color:isSelected? AppColor.fieldBg: AppColor.white,
                                                borderRadius: BorderRadius.circular(15),
                                                border: Border.all(
                                                  color: isSelected? AppColor.apptheme: AppColor.rowbox, 
                                                  width: 1.5
                                                )
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      dayName, 
                                                      style: TextStyle(
                                                        color: isSelected? AppColor.apptheme: AppColor.description,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600
                                                      ),
                                                    
                                                    ),
                                                    Text(
                                                      dayDate,
                                                      style: TextStyle(
                                                        color: isSelected? AppColor.apptheme: AppColor.fontColor,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w700
                                                
                                                      ),
                                                    
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                           );
  }
}