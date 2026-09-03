

import 'dart:async';

import 'package:flutter_application_9_klitou/features/orders/models/my_order_model.dart';
import 'package:flutter_application_9_klitou/features/orders/models/order_model.dart';
import 'package:flutter_application_9_klitou/features/orders/repository/order_repository.dart';
import 'package:flutter_application_9_klitou/features/orders/state/providers/order_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderNotifier extends AsyncNotifier<List<Order>> {
  OrderRepository get _repository =>
    ref.read(orderRepositoryProvider);

  @override
  FutureOr<List<Order>> build()async {
    
    return _repository.getCart();
  }


  Future<void> addOrder(Order order) async {
  final repository = ref.read(orderProvider);
  final currentOrders = state.value ?? [];

  state = await AsyncValue.guard(() async {
    final id = await repository.orderNow(order: order);

    final addedOrder = Order(
      id: id,
      meal: order.meal,
      price: order.price,
      quantity: order.quantity,
      deliveryDate: order.deliveryDate,
    );

    return [...currentOrders, addedOrder];
  });
}

  

  Future<void> deleteOrder(int index) async{
    final repository = ref.read(orderProvider);
    final currentOrders = state.value ?? [];
    
    final order= currentOrders[index];
    
    state = AsyncLoading();
    state = await AsyncValue.guard(()async {
     
      await repository.deleteCart(order.id!);
      
      final updatedOrder = [...currentOrders]..removeAt(index);
      return updatedOrder;

    },);


  }
}


class MyPreparingOrder extends AsyncNotifier<List<MyOrder>> {
   OrderRepository get _repository =>
    ref.read(orderRepositoryProvider);

  @override
  FutureOr<List<MyOrder>> build()async {
  
    final result = await _repository.getPreaparingMeals();
    
    

    return result ;
  }
}


class MyDoneOrder extends AsyncNotifier<List<MyOrder>> {
   OrderRepository get _repository =>
    ref.read(orderRepositoryProvider);

  @override
  FutureOr<List<MyOrder>> build()async {
    
    return await _repository.getPassedMeals();
  }
}



