import 'package:flutter/material.dart';



class DeleteItem {
  Future<void> showDeleteDialog(
    BuildContext context, 
    VoidCallback onDelete,
     ) async {
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
    
    onDelete();
    
    
    

  }
  
}}