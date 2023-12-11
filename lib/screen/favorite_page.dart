import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe_plates/db/functions/functions.dart';
import 'package:recipe_plates/db/mode/model.dart';
import 'package:recipe_plates/screen/menu.dart';

class FavouritePageWidget extends StatefulWidget {
  const FavouritePageWidget({Key? key});

  @override
  State<FavouritePageWidget> createState() => _FavouritePageWidgetState();
}

initState() {
  getAllRecipiesByList();
}

class _FavouritePageWidgetState extends State<FavouritePageWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: buildAppBarWidget('Favourites'),
        body: buildFavouriteGridView(),
      ),
    );
  }

  AppBar buildAppBarWidget(String appBarText) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white10,
      title: Text(
        appBarText,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  Widget buildFavouriteGridView({
    dynamic itemCount,
  }) {
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
        itemCount: cartitems.length,
        itemBuilder: (context, index) {
          final recipe = cartitems[index];
          return buildGridItem(
            image: recipe.image,
            iconData: recipe.isFavorite
                ? Icons.favorite
                : Icons.favorite_outline_outlined,
            text1: recipe.name,
            index: index,
            recipe: recipe,
          );
        },
      ),
    );
  }

  Widget buildGridItem({
    required String? image,
    required IconData iconData,
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
              color: Color.fromARGB(255, 194, 176, 176),
              offset: Offset(8.0, 8.0),
              blurRadius: 0,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Color.fromARGB(255, 255, 255, 255),
              blurRadius: 1,
              spreadRadius: 0,
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
                  child: Image.asset(
                    image,
                    height: 100,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              Positioned(
                top: 7,
                right: 7,
                child: IconButton(
                  onPressed: () {
                    deleteFromFavourite(index);
                  },
                  icon: const Icon(Icons.favorite_outline),
                ),
              ),
              Positioned(
                left: 50,
                bottom: 30,
                child: Text(
                  text1,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
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
