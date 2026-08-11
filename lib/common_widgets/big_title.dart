import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/common/app_color.dart';

class BigTitle extends StatelessWidget {
  final String title;
  const BigTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title,
     style: TextStyle(
       color: AppColor.fontColor,
       fontWeight: FontWeight.w500,
       fontSize: 30,

     ),
    );
  }
}