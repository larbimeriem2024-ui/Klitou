import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/common/app_color.dart';

class TimeBox extends StatelessWidget {
  final TimeOfDay time;
  final String period;
  final bool isSelected;
  final VoidCallback onTap;
   const TimeBox({super.key, required this.time, required this.period, required this.isSelected, required this.onTap});

 
   

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                                            onTap: onTap,
                                            child: Container(
                                              height: 112,
                                              width: 100,
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
                                                      period, 
                                                      style: TextStyle(
                                                        color: isSelected? AppColor.apptheme: AppColor.description,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600
                                                      ),
                                                    
                                                    ),
                                                    Text(
                                                      time.format(context),
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