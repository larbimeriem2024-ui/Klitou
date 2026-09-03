import 'package:flutter_application_9_klitou/features/orders/models/my_order_model.dart';
import 'package:flutter_application_9_klitou/features/orders/models/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderRepository {
  final SupabaseClient _client;
  OrderRepository({required SupabaseClient client}) : _client = client;

  String get _uid {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw StateError('Not authenticated');
    }
    return user.id;
  }

  Future<int> orderNow({required Order order}) async {
    final data = await _client
        .from('cart')
        .insert({...order.toJson(), 'user_id': _uid})
        .select('id')
        .single();
    return data['id'] as int;
  }

  Future<List<Order>> getCart() async {
    final data = await _client
        .from('cart')
        .select('''
              *,
           meals(*)
                 ''')
        .eq('user_id', _uid);

    return data.map((order) {
      return Order.fromJson(order);
    }).toList();
  }

  Future<void> deleteCart(int id) async {
    await Supabase.instance.client
        .from('cart')
        .delete()
        .eq('id', id)
        .eq('user_id', _uid);
  }

  Future<List<MyOrder>> getPreaparingMeals() async {
    final data = await _client
        .from('order_items')
        .select('''
*,
meals(*)
      
    ''')
        .eq('user_id', _uid)
        .eq('status', 'paid');


    return data.map((myorder) {
      return MyOrder.fromJson(myorder);
    }).toList();
  }

   Future<List<MyOrder>> getPassedMeals() async {
    
   
    final data = await _client
        .from('order_items')
        .select('''
*,
meals(*)
      
    ''')
        .eq('user_id', _uid)
        .eq('status', 'delivered');

    return data.map((myorder) {
      return MyOrder.fromJson(myorder);
    },).toList();
  }
}
