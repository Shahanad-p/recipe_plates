import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:recipe_plates/functions/model/model.dart';

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
  final recipeDB = await Hive.openBox<recipeModel>('recipies_db');
  await recipeDB.putAt(index, newRecipe);
  getAllRecipiesByList();
}

Future<void> addToFavourite(recipeModel data) async {
  final cartdb = await Hive.openBox<recipeModel>('favorite_db');
  cartitems.add(data);
  cartdb.add(data);
  // recipeNotifier.notifyListeners();
  getAllRecipiesByList();
}

Future<void> deleteFromFavourite(int index) async {
  final cartdb = await Hive.openBox<recipeModel>('favorite_db');
  cartdb.deleteAt(index);
  cartitems.removeAt(index);
  getAllRecipiesByList();
}

double calculateTotalCost(List<recipeModel> foods) {
  double totalCost = 0;
  for (var food in foods) {
    totalCost += double.parse(food.cost);
  }
  return totalCost;
}
