import 'package:flutter_application_9_klitou/features/meals/models/meal_model.dart';

class MyOrder{
  final String? id;
  final Meal meal;
  final double price;
  final DateTime deliveryDate;

 const MyOrder({
    this.id,
    required this.meal,
    required this.price, 
    required this.deliveryDate
  });

  Map<String, dynamic> toJson(){
    return {
      'meal_id': meal.id,
      'unit_price': price,
      'pickup_date': deliveryDate.toIso8601String()
    };
  }

  factory MyOrder.fromJson (Map<String, dynamic> json){
    return MyOrder(
      id: json['id'] as String,
      meal: Meal.fromJson(json['meals'] as Map<String, dynamic>), 
      price:  (json['unit_price'] as num).toDouble(), 
      deliveryDate: DateTime.parse(json['pickup_date'] as String));
  }

}