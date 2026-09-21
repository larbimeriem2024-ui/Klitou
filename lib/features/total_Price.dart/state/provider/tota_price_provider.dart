

import 'package:flutter_application_9_klitou/features/orders/state/providers/cart_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final totalPriceProvider = Provider<double>((ref) {
  final orders = ref.watch(cartProvider).value ?? [];

  return orders.fold(
    0,
    (total, order) => total + order.price * order.quantity ,


  );

},);