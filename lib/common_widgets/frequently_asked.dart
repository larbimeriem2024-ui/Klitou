import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/common/app_color.dart';

class FrequentlyAsked extends StatelessWidget {
  final String title;
  const FrequentlyAsked({
    super.key,
    required this.title
    });

  @override
  Widget build(BuildContext context) {
    return Container(
                    height: 56,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: AppColor.fontColor,
                              fontSize: 16, 
                              fontWeight: FontWeight.w500
                            ),
                            ),
                          Image.asset(
                            'assets/imgs/arrow.png',
                            height: 20,
                            width: 20,
                            color: AppColor.fontColor,
                            )
                        ],
                      ),
                    ),
                  );
  }
}