
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderService  {
  final supabase = Supabase.instance.client;

  Future<void> orderNow({
    required int mealId,
    required int quantity,
    required DateTime date,
    required double price,
  }) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    await supabase.from('cart').insert({
      'user_id': user.id,
      'meal_id': mealId,
      'quantity': quantity,
      'date': date.toIso8601String(),
      'price': price,
    });
  }

  static Future<List<Map<String, dynamic>>> getCart() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    final data = await Supabase.instance.client
        .from('cart')
        .select('''
              *,
           meals(*)
                 ''')
        .eq('user_id', user.id);

    return List<Map<String, dynamic>>.from(data);
  }



  static Future<List<Map<String, dynamic>>> deleteCart(int index)  async  {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    final data = await Supabase.instance.client
        .from('cart')
        .delete()
        .eq('id', index);
        
    
    return List<Map<String, dynamic>>.from(data);
    
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
