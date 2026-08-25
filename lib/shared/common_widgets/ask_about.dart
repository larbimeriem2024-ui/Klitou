import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';

class AskAbout extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  const AskAbout({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle



    });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
                  width: (media.width /2) - 16,
                  height: 136,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: AppColor.fieldBg,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              image,
                              color: AppColor.description,
                              height: 20,
                              width: 20,
                              ),
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Text(
                          title,
                          style: TextStyle(
                            color: AppColor.fontColor,
                            fontSize: 16, 
                            fontWeight: FontWeight.w700
                          ),
                          ),
                          Text(
                          subtitle,
                          style: TextStyle(
                            color: AppColor.fontColor,
                            fontSize: 14, 
                            fontWeight: FontWeight.w500
                          ),
                          ),
                        
                      ],
                    ),
                  ),
                );
  }
}