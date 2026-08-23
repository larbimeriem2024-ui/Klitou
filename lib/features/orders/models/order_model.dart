import 'package:flutter_application_9_klitou/features/meals/models/meal_model.dart';

class Order{
  final int? id;
  final Meal meal;
  final double price;
  final int quantity; 
  final DateTime deliveryDate;

 const Order({
    this.id,
    required this.meal,
    required this.price, 
    required this.quantity,
    required this.deliveryDate
  });

  Map<String, dynamic> toJson(){
    return {
      'meal_id': meal.id,
      'price': price,
      'quantity' : quantity,
      'date': deliveryDate.toIso8601String()
    };
  }

  factory Order.fromJson (Map<String, dynamic> json){
    return Order(
      id: json['id'] as int,
      meal: Meal.fromJson(json['meals'] as Map<String, dynamic>), 
      price: json['price'] as double, 
      quantity: json['quantity'] as int, 
      deliveryDate: DateTime.parse(json['date'] as String));
  }

}