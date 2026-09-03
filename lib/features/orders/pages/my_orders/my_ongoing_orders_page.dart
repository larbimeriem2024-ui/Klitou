

import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/orders/state/providers/order_provider.dart';
import 'package:flutter_application_9_klitou/features/orders/widget/my_orders_dish.dart';
import 'package:flutter_application_9_klitou/features/profile/pages/notification_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class MyOngoingOrdersPage extends ConsumerWidget {
  const MyOngoingOrdersPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final myPreparingOrders = ref.watch(preparingOrderProvider);
    final onGoingOrders = myPreparingOrders.value!.length;
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'In PROGRESS',
                    style: TextStyle(
                      color: AppColor.apptheme,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  Text(
                    '$onGoingOrders Active',
                    style: TextStyle(
                      color: AppColor.description,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),

              myPreparingOrders.when(
                data: (order) {

                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: order.length,
                    itemBuilder: (context, index) {
                      final dish = order[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: GestureDetector(
                          onTap: () {},
                          child: MyOrdersDish(
                           order: dish,
                           isInProgress: true,
                          ),));
              });},
              error: (error, stackTrace) {
                
                return Text(error.toString());
                
                },
              loading: () => CircularProgressIndicator(),
              ), ])
              )
              )
              );
  }
}