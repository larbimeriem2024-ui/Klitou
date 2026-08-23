

import 'package:flutter_application_9_klitou/features/orders/state/notifiers/order_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final totalPriceProvider = Provider<double>((ref) {
  final orders = ref.watch(allOrdersProvider).value ?? [];

  return orders.fold(
    0,
    (total, order) => total + order.price * order.quantity ,


  );

},);