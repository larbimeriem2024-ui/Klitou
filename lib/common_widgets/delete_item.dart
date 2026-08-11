import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/services/order_service.dart';
class DeleteItem {
  Future<void> showDeleteDialog(BuildContext context, int index ) async {
  final bool? shouldDelete = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete Item"),
        content: const Text(
          "Are you sure you want to delete this item?",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false); // User cancelled
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true); // User confirmed
            },
            child: const Text("Delete"),
          ),
        ],
      );
    },
  );

  if (shouldDelete == true) {
    
    // Delete dthe item here
    
    await OrderService.deleteCart(index);
    
    
    

  }
  
}}