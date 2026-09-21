

import 'dart:async';

import 'package:flutter_application_9_klitou/features/orders/models/my_order_model.dart';
import 'package:flutter_application_9_klitou/features/orders/models/cart_item_model.dart';
import 'package:flutter_application_9_klitou/features/orders/repository/order_repository.dart';
import 'package:flutter_application_9_klitou/features/orders/state/providers/cart_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartNotifier extends AsyncNotifier<List<CartItem>> {
  OrderRepository get _repository =>
    ref.read(cartRepositoryProvider);

  @override
  FutureOr<List<CartItem>> build()async {
    
    return _repository.getCart();
  }


  Future<void> addToCart(CartItem item) async {
  final repository = ref.read(cartRepositoryProvider);
  final currentOrders = state.value ?? [];

  state = await AsyncValue.guard(() async {
    final id = await repository.addToCart(item: item);

    final addedOrder = CartItem(
      id: id,
      meal: item.meal,
      price: item.price,
      quantity: item.quantity,
      deliveryAt: item.deliveryAt,
    );

    return [...currentOrders, addedOrder];
  });
}

  

  Future<void> removeFromCart(int index) async{
    final repository = ref.read(cartRepositoryProvider);
    final currentOrders = state.value ?? [];
    
    final order= currentOrders[index];
    
    state = AsyncLoading();
    state = await AsyncValue.guard(()async {
     
      await repository.deleteCartItem(order.id!);
      
      final updatedOrder = [...currentOrders]..removeAt(index);
      return updatedOrder;

    },);


  }
}


class MyPreparingOrder extends AsyncNotifier<List<MyOrder>> {
   OrderRepository get _repository =>
    ref.read(cartRepositoryProvider);

  @override
  FutureOr<List<MyOrder>> build()async {
  
    final result = await _repository.getPreaparingMeals();
    
    

    return result ;
  }
}


class MyDoneOrder extends AsyncNotifier<List<MyOrder>> {
   OrderRepository get _repository =>
    ref.read(cartRepositoryProvider);

  @override
  FutureOr<List<MyOrder>> build()async {
    
    return await _repository.getPassedMeals();
  }
}



