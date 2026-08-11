

import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/services/order_service.dart';

class TotalPriceNotifier extends ChangeNotifier {
  
  double _total = 0;



  
  double get total => _total;
  

 Future <void> subtotalCalc() async{
  _total = await OrderService.getCartTotal();
 notifyListeners();
}

Future<void> removeSubtotalCalc()async{
  _total =  await OrderService.getCartTotal();
  notifyListeners();
}



  

}