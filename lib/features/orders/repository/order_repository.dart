
import 'package:flutter_application_9_klitou/features/orders/models/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderRepository  {
  final SupabaseClient client;
   OrderRepository({
    required this.client
  });
  

  Future<int> orderNow({
    required Order order
  }) async {
    
final userId = client.auth.currentUser!.id;
   final data = await client.from('cart')
    .insert({
      ...order.toJson(), 
      'user_id':userId
    })
    .select('id')
    .single();
    return data['id'] as int;



    
  }

    Future<List<Order>> getCart() async {
    final user = Supabase.instance.client.auth.currentUser;
    
    

    final data = await Supabase.instance.client
        .from('cart')
        .select('''
              *,
           meals(*)
                 ''')
        .eq('user_id', user!.id);
        

        print('here are your orders orders orders: $data');

    return data.map((order) {
      return Order.fromJson(order );
      
    },).toList();
  }



   Future<void> deleteCart(int id)  async  {
    await Supabase.instance.client
        .from('cart')
        .delete()
        .eq('id', id);
        
        
    
    
  }


  static Future<double> getCartTotal() async {
  final user = Supabase.instance.client.auth.currentUser;

  if (user == null) {
    throw Exception("User not logged in");
  }

  final result = await Supabase.instance.client.rpc(
    'get_cart_total',
    params: {
      'p_user_id': user.id,
    },
  );

  return (result as num).toDouble();
}

static Future <List<Map<String, dynamic>>> getPreaparingMeals()async{
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;

  if(user == null){
    throw Exception('user not logged in ');
  }
  final data = await supabase.from('order_items')
  .select('''
*,
meals(*),
orders!inner(status)
      
    '''
)
.eq('user_id', user.id)
.eq('orders.status', 'paid');


return List<Map<String, dynamic>>.from(data);
}

static Future <List<Map<String, dynamic>>> getPassedMeals()async{
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;

  if(user == null){
    throw Exception('user not logged in ');
  }
  final data = await supabase.from('order_items')
  .select('''
*,
meals(*),
orders!inner(status)
      
    '''
)
.eq('user_id', user.id)
.eq('orders.status', 'done');


return List<Map<String, dynamic>>.from(data);
}

}
