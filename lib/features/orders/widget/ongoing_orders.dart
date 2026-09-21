import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/orders/state/providers/cart_provider.dart';
import 'package:flutter_application_9_klitou/features/orders/widget/my_orders_dish.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OngoingOrders extends ConsumerWidget {
  const OngoingOrders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myPreparingOrders = ref.watch(preparingOrderProvider);

    final onGoingOrders = myPreparingOrders.value!.length;
    return Column(
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
                    child: MyOrdersDish(order: dish, isInProgress: true),
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
