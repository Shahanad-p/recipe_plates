import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class recipeModel {
  @HiveField(0)
  int? index;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String ingredients;

  @HiveField(5)
  final String cost;

  @HiveField(6)
  String? image;

  bool isFavorite;

  recipeModel(
      {required this.name,
      required this.category,
      required this.description,
      required this.ingredients,
      required this.cost,
      required this.image,
      this.index,
      this.isFavorite = false});
}
