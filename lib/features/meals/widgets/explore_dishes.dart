import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/view_all.dart';
import 'package:go_router/go_router.dart';
class ExploreDishes extends StatelessWidget {
  const ExploreDishes({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    'Explore dishes ',
                    style: TextStyle(
                      color: AppColor.fontColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  ViewAll(onPressed: () {
                    context.go('/menu');
                  },),
                ],
              );
  }
}