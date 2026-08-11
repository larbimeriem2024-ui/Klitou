import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/services/order_service.dart';
import 'package:flutter_application_9_klitou/views/shopping/empty_cart_page.dart';
import 'package:flutter_application_9_klitou/views/shopping/shopping_page.dart';
class CartSwitcher extends StatelessWidget {
  final VoidCallback browsDishes;
  
  const CartSwitcher({super.key, required this.browsDishes, });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: OrderService.getCart(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final cart = snapshot.data ?? [];

        if (cart.isEmpty) {
          return  EmptyCartPage(exploreDishes: browsDishes);
        }

        return ShoppingPage(); // or simply ShoppingPage()
      },
    );
  }
}