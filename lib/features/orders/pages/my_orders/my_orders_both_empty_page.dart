import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/meals/state/notifiers/meals_notifier.dart';
import 'package:flutter_application_9_klitou/features/meals/widgets/recommended_meals.dart';
import 'package:flutter_application_9_klitou/features/profile/pages/notification_page.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/button.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/view_all.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MyOrdersBothEmptyPage extends ConsumerWidget {
  const MyOrdersBothEmptyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meals = ref.watch(allMealsProvider);
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
              "Looks like you haven't ordered anything Yet",
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

            SizedBox(height: 32),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  'Recommended for you ',
                  style: TextStyle(
                    color: AppColor.fontColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                ViewAll(
                  onPressed: () {
                    context.go('/menu');
                  },
                ),
              ],
            ),

            meals.when(
              data: (meals) {
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      var dish = meals[index];
                      return RecommendedMeals(
                        meal: dish,
                        onTap: () {
                          context.push('/order-meal', extra: dish);
                        },
                      );
                    },
                  ),
                );
              },
              error: (error, stackTrace) {
                return Text('Error: $error');
              },
              loading: () {
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
