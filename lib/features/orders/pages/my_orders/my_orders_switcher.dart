import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/features/orders/pages/my_orders/my_ongoing_orders_page.dart';
import 'package:flutter_application_9_klitou/features/orders/pages/my_orders/my_orders_both_empty_page.dart';
import 'package:flutter_application_9_klitou/features/orders/pages/my_orders/my_orders_page.dart';
import 'package:flutter_application_9_klitou/features/orders/pages/my_orders/my_past_orders_page.dart';
import 'package:flutter_application_9_klitou/features/orders/state/providers/order_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyOrdersSwitcher extends ConsumerWidget {
  const MyOrdersSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prpOrders = ref.watch(preparingOrderProvider);
    final pastOrders = ref.watch(myDoneOrderProvider);

   

    // Wait until both providers have finished loading
    if (prpOrders.isLoading || pastOrders.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final onGoingOrders = prpOrders.value ?? [];
    final passedOrders = pastOrders.value ?? [];

   
    if (onGoingOrders.isEmpty && passedOrders.isEmpty) {
      return const MyOrdersBothEmptyPage();
    }

    if (onGoingOrders.isEmpty && passedOrders.isNotEmpty) {
      return const MyPastOrdersPage();
    }

    if (onGoingOrders.isNotEmpty && passedOrders.isEmpty) {
      return const MyOngoingOrdersPage();
    }

    return const MyOrdersPage();
  }
}