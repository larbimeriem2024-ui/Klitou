import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/orders/state/providers/cart_provider.dart';
import 'package:flutter_application_9_klitou/features/orders/widget/my_orders_dish.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PastOrders extends ConsumerWidget {
  const PastOrders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alldoneOrders = ref.watch(myDoneOrderProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PAST ORDERS',
          style: TextStyle(
            color: AppColor.description,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),

        SizedBox(height: 16),

        alldoneOrders.when(
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
                    child: MyOrdersDish(order: dish, isInProgress: false),
                  ),
                );
              },
            );
          },
          error: (error, stackTrace) {
            return Text(error.toString());
          },
          loading: () => CircularProgressIndicator(),
        ),
      ],
    );
  }
}
