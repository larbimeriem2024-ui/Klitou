import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/common/app_color.dart';

class WhySubscribe extends StatelessWidget {
  final String icon;
  final String title;
  const WhySubscribe({
    super.key,
    required this.icon, 
    required this.title
    });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
                  width: (media.width /2) - 16,
                  height: 83,
                  decoration: BoxDecoration(
                    color: AppColor.fieldBg,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          icon,
                          color: AppColor.apptheme,
                          height: 20,
                          width: 20,
                          ),
                          SizedBox(height: 8,),
                        
                        Text(
                          title,
                          style: TextStyle(
                            color: AppColor.apptheme,
                            fontSize: 16, 
                            fontWeight: FontWeight.w500
                          ),
                          ),
                          
                        
                      ],
                    ),
                  ),
                );
  }
}