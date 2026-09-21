

import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/orders/widget/past_orders.dart';
import 'package:flutter_application_9_klitou/features/profile/pages/notification_page.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class MyPastOrdersPage extends ConsumerWidget {
  const MyPastOrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  
  
 

  
    return  Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: AppColor.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset('assets/imgs/back.png', height: 25, width: 25),
            ),

            Text(
              'My orders',
              style: TextStyle(
                color: AppColor.apptheme,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
              },
              child: Image.asset('assets/imgs/bell.png', height: 25, width: 25),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
              'Your Order History is Empty',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.fontColor,
                fontWeight: FontWeight.w500,
                fontSize: 30,
              ),
            ),
                  SizedBox(height: 8),
                  Text(
                    "Looks like you don't have any ongoing orders",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.description,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 16),
                  Button(
                    onClicked: () {
                    context.go('/menu');
                    },
                    color: AppColor.apptheme,
                    title: 'Browse Dishes',
                    fontColor: AppColor.white,
                    isborder: false,
                  ),
                  SizedBox(height: 16,),

              SizedBox(height: 16),
             PastOrders(),

              
            ],
          ),
        ),
      ),
    );

  }
  


   
  
}