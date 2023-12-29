import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:recipe_plates/functions/functions/functions.dart';
import 'package:recipe_plates/functions/model/model.dart';
import 'package:recipe_plates/screen/splash_screen.dart';

Future<void> resetRecipe(
  BuildContext context,
) async {
  bool confirmResetDatas = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          "Confirm Reset",
          style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
        ),
        content: const Text(
          "This will delete this cart. This action is irreversible. Do you want to continue ?",
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              "Cancel",
              style: TextStyle(color: Color.fromARGB(255, 5, 5, 5)),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text(
              "Reset",
              style: TextStyle(color: Color.fromARGB(255, 245, 0, 0)),
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );

  if (confirmResetDatas == true) {
    final clearAllRecipe = await Hive.openBox<recipeModel>('recipe_db');
    clearAllRecipe.clear();
    favoriteItems.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SplashScreenWidget(),
      ),
    );
  }
}
