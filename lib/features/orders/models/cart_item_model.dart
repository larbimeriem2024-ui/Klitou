import 'package:flutter_application_9_klitou/features/meals/models/meal_model.dart';

class CartItem{
  final int? id;
  final Meal meal;
  final double price;
  final int quantity; 
  final DateTime deliveryAt;

 const CartItem({
    this.id,
    required this.meal,
    required this.price, 
    required this.quantity,
    required this.deliveryAt
  });

  Map<String, dynamic> toJson(){
    return {
      'meal_id': meal.id,
      'price': price,
      'quantity' : quantity,
      'date': deliveryAt.toIso8601String()
    };
  }

  factory CartItem.fromJson (Map<String, dynamic> json){
    return CartItem(
      id: json['id'] as int,
      meal: Meal.fromJson(json['meals'] as Map<String, dynamic>), 
      price: (json['price'] as num).toDouble(), 
      quantity: json['quantity'] as int, 
      deliveryAt: DateTime.parse(json['date'] as String));
  }

}