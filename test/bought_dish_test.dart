


import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/common_widgets/bought_dish.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
testWidgets('hello this is my first time testing this thing', (tester)async{
  final testDate = DateTime(2026, 07, 30, 10, 30);
  await tester.pumpWidget(MaterialApp(home: BoughtDish(image: 'assets/imgs/menu1.png', title: 'Rice', price: '70,00', quantity: 8, date: testDate, index: 15 )));

  final title = find.text('Rice');
  final price = find.text('70.00 Dz');
  final quantity = find.text('8 items');
  


  
  expect(title, findsOneWidget);
  expect(price, findsOneWidget);
  
  expect(quantity, findsOneWidget);
  
      expect(find.text('2026-07-30 10:30:00'), findsOneWidget);

  
}


);
}
