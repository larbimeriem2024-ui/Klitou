import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/orders/widget/my_orders_dish.dart';
import 'package:flutter_application_9_klitou/features/orders/repository/order_repository.dart';
import 'package:flutter_application_9_klitou/views/profile/notification_page.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  late Future<List<Map<String, dynamic>>> cartFuture;
  late Future<List<Map<String, dynamic>>> pastFuture;


  @override
  void initState() {
    super.initState();
    cartFuture = OrderRepository.getPreaparingMeals();
    pastFuture = OrderRepository.getPassedMeals();
  }

  void refreshCart() {
    setState(() {
      cartFuture = OrderRepository.getPreaparingMeals();
      pastFuture = OrderRepository.getPassedMeals();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    '1 Active',
                    style: TextStyle(
                      color: AppColor.description,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),

              FutureBuilder(
                future: cartFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  final dishes = snapshot.data ?? [];

                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: dishes.length,
                    itemBuilder: (context, index) {
                      final dish = dishes[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: GestureDetector(
                          onTap: () {},
                          child: MyOrdersDish(
                            image: dish['meals']['image_url'],
                            title: dish['meals']['name'],
                            price: (dish['meals']['price']).toString(),
                            quantity: dish['unit_price']!,
                            date: DateTime.parse(dish['pickup_date']),
                            index: 0,
                            isInProgress: true,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),

              SizedBox(height: 16),
              Text(
                'PAST ORDERS',
                style: TextStyle(
                  color: AppColor.description,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 16),

              FutureBuilder(
                future: pastFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  final dishes = snapshot.data ?? [];

                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: dishes.length,
                    itemBuilder: (context, index) {
                      final dish = dishes[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: GestureDetector(
                          onTap: () {},
                          child: MyOrdersDish(
                            image: dish['meals']['image_url'],
                            title: dish['meals']['name'],
                            price: (dish['meals']['price']).toString(),
                            quantity: dish['unit_price']!,
                            date: DateTime.parse(dish['pickup_date']),
                            index: 0,
                            isInProgress: true,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
