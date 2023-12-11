import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:recipe_plates/db/mode/model.dart';
import 'package:recipe_plates/screen/update_page.dart';

ValueNotifier<List<recipeModel>> recipeNotifier = ValueNotifier([]);
List<recipeModel> cartitems = [];

Future<void> addRecipies(recipeModel value) async {
  final recipedb = await Hive.openBox<recipeModel>('recipe_db');
  await recipedb.add(value);
  recipeNotifier.value.add(value);
  recipeNotifier.notifyListeners();
}

Future<void> getAllRecipiesByList() async {
  final recipedb = await Hive.openBox<recipeModel>('recipe_db');
  recipeNotifier.value.clear();
  recipeNotifier.value.addAll(recipedb.values);
  recipeNotifier.notifyListeners();
}

Future<void> deleteRecipies(int index) async {
  final recipedb = await Hive.openBox<recipeModel>('recipe_db');
  await recipedb.deleteAt(index);
  getAllRecipiesByList();
}

Future<void> updateRecipe(int index, recipeModel newRecipe) async {
  // try {
  //   final recipeDB = await Hive.openBox<recipeModel>('recipies_db');
  //   await recipeDB.putAt(index, newRecipe);
  //   print(recipeDB.values);
  //   getAllRecipiesByList();
  // } catch (e) {
  //   debugPrint('Error updating recipe: $e');
  // }
  final recipeDB = await Hive.openBox<recipeModel>('recipies_db');
  await recipeDB.putAt(index, newRecipe);
  print(recipeDB.values);
  getAllRecipiesByList();
}

Future<void> addToFavourite(recipeModel data) async {
  final cartdb = await Hive.openBox<recipeModel>('cart_db');
  cartitems.add(data);
  cartdb.add(data);
  recipeNotifier.notifyListeners();
  getAllRecipiesByList();
}

Future<void> deleteFromFavourite(int index) async {
  final cartdb = await Hive.openBox<recipeModel>('cart_db');
  cartdb.deleteAt(index);
  cartitems.removeAt(index);
  getAllRecipiesByList();
}

// Future<void> updateAllRecipies(int index) async {
//   final recipedb = await Hive.openBox<recipeModel>('recipe_db');
//   // final recipeUpdate = recipeModel(
//   //   name: nameController.text,
//   //   category: categoryController.text,
//   //   description: descriptionController.text,
//   //   ingredients: ingredientsController.text,
//   //   cost: costController.text,
//   //   image: image,
//   // );
//   await recipedb.putAt(index, recipeUpdate);
//   getAllRecipiesByList();
// }
