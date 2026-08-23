
class Meal {
  final int id;
  final String image;
  final String title;
  final double price;
  final double rate;

   Meal({
    required this.id,
    required this.image, 
    required this.title, 
    required this.price, 
    required this.rate
  });
  factory Meal.fromJson (Map<String, dynamic> json){
    return Meal(
      id: json['id'] as int , 
      image: json['image_url'] as String, 
      title: json['name'] as String, 
      price: (json['price'] as num).toDouble(), 
      rate: (json['rating'] as num).toDouble());
  }
}