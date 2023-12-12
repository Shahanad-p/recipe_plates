import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe_plates/db/functions/functions.dart';
import 'package:recipe_plates/db/mode/model.dart';
import 'package:recipe_plates/screen/menu.dart';

class FastfoodPage extends StatelessWidget {
  const FastfoodPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fastfood',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ValueListenableBuilder(
        valueListenable: recipeNotifier,
        builder:
            (BuildContext ctx, List<recipeModel> recipeList, Widget? child) {
          final filteredFastfoodList = recipeList
              .where((food) => food.category.toLowerCase() == 'fastfood')
              .toList();

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
            ),
            itemCount: filteredFastfoodList.length,
            itemBuilder: (context, index) {
              final recipeData = filteredFastfoodList[index];
              File? recipeImage;
              if (recipeData.image != null) {
                recipeImage = File(recipeData.image!);
              }

              return buildGridList(
                context,
                image: recipeImage,
                icon: Icons.favorite_border_outlined,
                text: recipeData.name,
                category: recipeData.category,
                description: recipeData.description,
                ingredients: recipeData.ingredients,
                cost: recipeData.cost,
                editIcon: IconButton(
                  onPressed: () {
                    // Handle edit action
                  },
                  icon: const Icon(Icons.edit),
                ),
                deleteIcon: IconButton(
                  onPressed: () {
                    deleteRecipies(index);
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildGridList(
    BuildContext context, {
    File? image,
    IconData? icon,
    String? text,
    String? category,
    String? description,
    String? ingredients,
    String? cost,
    IconButton? deleteIcon,
    IconButton? editIcon,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MenuOpeningPage(
              name: text,
              category: category,
              description: description!,
              ingredients: ingredients!,
              cost: cost!,
              selectedImagePath: image!,
            ),
          ),
        );
      },
      child: Card(
        elevation: 5,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: image != null
                  ? Image.file(
                      image,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                deleteIcon!,
                editIcon!,
                const Positioned(
                  top: 2.0,
                  right: 2.0,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: null,
                      icon: Icon(Icons.favorite_outline),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 35,
              left: 35,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      text!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      category!,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 10, 65, 12),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '₹: ${cost.toString()}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
