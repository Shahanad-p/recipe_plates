import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe_plates/functions/functions/functions.dart';
import 'package:recipe_plates/functions/model/model.dart';
import 'package:recipe_plates/screen/menu.dart';

class BeveragesPage extends StatelessWidget {
  const BeveragesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Beverages',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.10,
            color: Colors.black,
          ),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ValueListenableBuilder(
        valueListenable: recipeNotifier,
        builder: (context, recipeList, child) {
          final filteredBeveragesList = recipeList
              .where((categorizedRecipes) =>
                  categorizedRecipes.category.toLowerCase() == 'beverages')
              .toList();

          return Padding(
            padding: const EdgeInsets.all(15.10),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredBeveragesList.length,
              itemBuilder: (context, index) {
                final recipeDatas = filteredBeveragesList[index];
                File? recipeImage;
                if (recipeDatas.image != null) {
                  recipeImage = File(recipeDatas.image!);
                }

                return buildGridList(
                  context,
                  image: recipeImage,
                  text: recipeDatas.name,
                  category: recipeDatas.category,
                  description: recipeDatas.description,
                  ingredients: recipeDatas.ingredients,
                  cost: recipeDatas.cost,
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildGridList(
    BuildContext context, {
    File? image,
    String? text,
    String? category,
    String? description,
    String? ingredients,
    String? cost,
  }) {
    double cardWidth = MediaQuery.of(context).size.width *
        (MediaQuery.of(context).orientation == Orientation.portrait
            ? 0.4
            : 0.2);
    double cardHeight = 120.0;

    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 2, 36, 17),
              offset: Offset(3.0, 3.0),
              blurRadius: 1,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Color.fromARGB(255, 255, 255, 255),
              blurRadius: 1,
              spreadRadius: 1,
            )
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MenuOpeningPage(
                name: text,
                category: category,
                description: description!,
                ingredients: ingredients!,
                cost: cost!,
                selectedImagePath: image!,
              ),
            ));
          },
          child: Padding(
            padding: const EdgeInsets.all(2.20),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.10),
                  child: image != null
                      ? Image.file(
                          image,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Container(),
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(2, 2),
                                blurRadius: 1,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          category!,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 54, 14, 7),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                offset: Offset(1, 1),
                                blurRadius: 0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
