// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_plates/functions/functions/functions.dart';
import 'package:recipe_plates/functions/model/model.dart';
import 'package:recipe_plates/screen/widget/splash_screen.dart';

Future<void> resetRecipe(BuildContext context) async {
  bool confirmResetDatas = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 229, 232, 227),
        content: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "This will be delete your all recipies. Do you want to continue..?",
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
              const SizedBox(height: 10.10),
              Lottie.asset('assets/Animation - 1703841326068.json',
                  height: 50.10, width: 50)
            ],
          ),
        ),
        actions: [
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
