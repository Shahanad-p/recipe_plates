import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe_plates/db/functions/functions.dart';
import 'package:recipe_plates/db/mode/model.dart';
import 'package:recipe_plates/screen/menu.dart';

class HealthyPage extends StatefulWidget {
  const HealthyPage({Key? key}) : super(key: key);

  @override
  State<HealthyPage> createState() => _HealthyPageState();
}

class _HealthyPageState extends State<HealthyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Healthy',
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
      body: ValueListenableBuilder<List<recipeModel>>(
        valueListenable: recipeNotifier,
        builder: (context, recipeList, child) {
          // Filter recipes based on the category
          final filteredHealthyList = recipeList
              .where((recipe) => recipe.category.toLowerCase() == 'healthy')
              .toList();

          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 2
                      : 4,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
            ),
            itemCount: filteredHealthyList.length,
            itemBuilder: (context, index) {
              final recipeData = filteredHealthyList[index];
              final recipeImage =
                  recipeData.image != null ? File(recipeData.image!) : null;

              // Build and return the recipe grid item
              return buildGridList(
                context,
                image: recipeImage,
                text: recipeData.name,
                category: recipeData.category,
                description: recipeData.description,
                ingredients: recipeData.ingredients,
                cost: recipeData.cost,
                deleteIcon: IconButton(
                  onPressed: () {
                    deleteRecipies(index);
                  },
                  icon: const Icon(Icons.delete),
                ),
                editIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
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
    double cardWidth = MediaQuery.of(context).size.width *
        (MediaQuery.of(context).orientation == Orientation.portrait
            ? 0.4
            : 0.2);
    double cardHeight = 150.0;

    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 229, 218, 218),
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
            padding: const EdgeInsets.all(2.10),
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
        ),
      ),
    );
  }
}
