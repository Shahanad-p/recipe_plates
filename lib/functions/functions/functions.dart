import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:recipe_plates/functions/model/model.dart';

ValueNotifier<List<recipeModel>> recipeNotifier = ValueNotifier([]);
List<recipeModel> favoriteItems = [];
ValueNotifier<List<recipeModel>> favoriteItemsNotifier =
    ValueNotifier<List<recipeModel>>([]);

Future<void> addRecipies(recipeModel value) async {
  final recipedb = await Hive.openBox<recipeModel>('recipe_db');
  await recipedb.add(value);
  recipeNotifier.value.add(value);
  recipeNotifier.notifyListeners();
}

Future<void> getAllRecipiesByList() async {
  await Hive.initFlutter();
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
  await Hive.initFlutter();
  final recipeDB = await Hive.openBox<recipeModel>('recipies_db');
  if (index >= 0 && index < recipeDB.length) {
    await recipeDB.putAt(index, newRecipe);
    getAllRecipiesByList();
  }
}

Future<void> getAllFavouriteRecipes() async {
  final favoriteBox = await Hive.openBox<recipeModel>('favorite_db');
  final favoriteItems = favoriteBox.values.toList();
  favoriteItemsNotifier.value = favoriteItems;
}

Future<void> addToFavourite(recipeModel recipe) async {
  final favoriteBox = await Hive.openBox<recipeModel>('favorite_db');
  bool isAlreadyInFavorites = favoriteItems.contains(recipe);
  if (!isAlreadyInFavorites) {
    favoriteBox.add(recipe);
    favoriteItems.add(recipe);
    recipeNotifier.value = List.from(recipeNotifier.value);
    favoriteItemsNotifier.value = favoriteItems;
  }
}

Future<void> deleteFromFavourite(int index) async {
  final favoriteBox = await Hive.openBox<recipeModel>('favorite_db');
  favoriteBox.deleteAt(index);
  favoriteItems.removeAt(index);
  recipeNotifier.value = List.from(recipeNotifier.value);
  favoriteItemsNotifier.value = favoriteItems;
  favoriteItemsNotifier.value = favoriteBox.values.toList();
}

calculateTotalCost(List<recipeModel> recipes) {
  double totalCost = 0;
  for (int i = 0; i < recipes.length; i++) {
    recipeModel recipe = recipes[i];
    totalCost += double.parse(recipe.cost);
  }
  return totalCost;
}
