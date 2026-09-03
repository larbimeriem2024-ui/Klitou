

import 'package:flutter_application_9_klitou/features/orders/models/my_order_model.dart';
import 'package:flutter_application_9_klitou/shared/providers/supabase_client_provider.dart';
import 'package:flutter_application_9_klitou/features/orders/models/order_model.dart';
import 'package:flutter_application_9_klitou/features/orders/repository/order_repository.dart';
import 'package:flutter_application_9_klitou/features/orders/state/notifiers/order_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderRepositoryProvider = Provider((ref) {
  final client = ref.read(supabaseClientProvider);
  return OrderRepository(client: client);
},);


final orderProvider = Provider((ref) {
  final order = ref.watch(orderRepositoryProvider);
  return order;
},);


final getOrderProvider = FutureProvider.autoDispose<List<Order>>((ref) {
  final currentOrder = ref.watch(orderRepositoryProvider).getCart();
  return currentOrder;
},);

final allOrdersProvider = AsyncNotifierProvider<OrderNotifier, List<Order>>(OrderNotifier.new);


final isCartEmptyProvider = Provider<bool>((ref) {
  final cartEmpty = ref.watch(allOrdersProvider).value!.isEmpty;

  return cartEmpty;
},);


final preparingOrderProvider = AsyncNotifierProvider<MyPreparingOrder, List<MyOrder>>(MyPreparingOrder.new);


final myDoneOrderProvider = AsyncNotifierProvider<MyDoneOrder, List<MyOrder>>(MyDoneOrder.new);
