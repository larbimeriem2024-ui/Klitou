



import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/features/orders/pages/shopping/empty_cart_page.dart';
import 'package:flutter_application_9_klitou/features/orders/pages/shopping/shopping_page.dart';
import 'package:flutter_application_9_klitou/features/orders/state/providers/order_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class CartSwitcher extends ConsumerWidget {
  const CartSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCartEmpty = ref.watch(allOrdersProvider).value;
     
    if (isCartEmpty== null || isCartEmpty.isEmpty ){
      return EmptyCartPage();
    }
    else
    {
      return ShoppingPage();
    }
  }
}