import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_plates/functions/functions/functions.dart';

Future<bool?> showDeleteConfirmationDialog(
    BuildContext context, int index) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              const Text(
                'Are you sure? you want to delete this recipe?',
                style: TextStyle(fontSize: 18),
              ),
              Lottie.asset('assets/Animation - 1702529005450.json', height: 60),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text(
              'No',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.red,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(false); // Return false for cancellation
            },
          ),
          TextButton(
            child: const Text(
              'Yes',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.green,
              ),
            ),
            onPressed: () {
              deleteRecipies(index);
              Navigator.of(context).pop(true); // Return true for confirmation
            },
          )
        ],
      );
    },
  );
}
