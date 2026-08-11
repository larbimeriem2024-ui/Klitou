import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/common/app_color.dart';

class DescriptionText extends StatelessWidget {
  final String title;
  const DescriptionText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, 
    style: TextStyle(
       color: AppColor.description,
       fontWeight: FontWeight.w400,
       fontSize: 14,

    ),);
  }
}