import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe_plates/functions/functions/functions.dart';
import 'package:recipe_plates/functions/model/model.dart';
import 'package:recipe_plates/screen/menu.dart';

class FavouritePageWidget extends StatefulWidget {
  const FavouritePageWidget({Key? key}) : super(key: key);

  @override
  _FavouritePageWidgetState createState() => _FavouritePageWidgetState();
}

class _FavouritePageWidgetState extends State<FavouritePageWidget> {
  @override
  void initState() {
    super.initState();
    getAllFavouriteRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: const Text(
            'Favourites',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: ValueListenableBuilder(
          valueListenable: favoriteItemsNotifier,
          builder: (BuildContext context, List<recipeModel> favoriteList,
              Widget? child) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 2
                          : 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: favoriteList.length,
                itemBuilder: (context, index) {
                  final recipe = favoriteList[index];
                  return buildGridItem(
                    image: recipe.image,
                    text1: recipe.name,
                    index: index,
                    recipe: recipe,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildGridItem({
    required String? image,
    required String text1,
    required int index,
    required recipeModel recipe,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 160,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 184, 177, 177),
              offset: Offset(8.0, 8.0),
              blurRadius: 1,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color.fromARGB(255, 255, 255, 255),
              offset: Offset(-3.0, -3.0),
              blurRadius: 10,
              spreadRadius: 1,
            )
          ],
        ),
        padding: const EdgeInsets.all(5),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MenuOpeningPage(
                    name: recipe.name,
                    category: recipe.category,
                    description: recipe.description,
                    ingredients: recipe.ingredients,
                    cost: recipe.cost,
                    selectedImagePath: File(
                      recipe.image!,
                    ))));
          },
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              if (image != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    File(image),
                    height: 160,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: () {
                    deleteFromFavourite(index);
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Color.fromARGB(255, 20, 60, 130),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
