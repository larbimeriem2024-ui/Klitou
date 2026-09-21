

import 'package:flutter_application_9_klitou/features/orders/models/my_order_model.dart';
import 'package:flutter_application_9_klitou/shared/providers/supabase_client_provider.dart';
import 'package:flutter_application_9_klitou/features/orders/models/cart_item_model.dart';
import 'package:flutter_application_9_klitou/features/orders/repository/order_repository.dart';
import 'package:flutter_application_9_klitou/features/orders/state/notifiers/cart_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartRepositoryProvider = Provider((ref) {
  final client = ref.read(supabaseClientProvider);
  return OrderRepository(client: client);
},);





final cartProvider = AsyncNotifierProvider<CartNotifier, List<CartItem>>(CartNotifier.new);





final preparingOrderProvider = AsyncNotifierProvider<MyPreparingOrder, List<MyOrder>>(MyPreparingOrder.new);


final myDoneOrderProvider = AsyncNotifierProvider<MyDoneOrder, List<MyOrder>>(MyDoneOrder.new);
