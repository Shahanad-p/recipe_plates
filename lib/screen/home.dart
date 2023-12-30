import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe_plates/functions/functions/functions.dart';
import 'package:recipe_plates/functions/model/model.dart';
import 'package:recipe_plates/screen/delete_snakbar.dart';
import 'package:recipe_plates/screen/edit_page.dart';
import 'package:recipe_plates/screen/home_decorate.dart';
import 'package:recipe_plates/screen/sidebar_drawer.dart';
import 'package:recipe_plates/shared_preference.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  List<recipeModel> displayedRecipes = [];
  TextEditingController searchController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  String userName = '';

  @override
  void initState() {
    super.initState();
    getData();
    getAllRecipiesByList();
    displayedRecipes = recipeNotifier.value;
    usernameController.dispose();
  }

  saveData() {
    SharedPreferenceServices.saveString(usernameController.text);
    usernameController.clear();
    getData();
    setState(() {});
  }

  getData() {
    if (SharedPreferenceServices.getString() != null) {
      userName = SharedPreferenceServices.getString()!;
    }
    setState(() {});
  }

  void updateRecipe(int index, recipeModel updatedRecipe) {
    setState(() {
      displayedRecipes[index] = updatedRecipe;
    });
  }

  void filterRecipes(String query) {
    setState(() {
      displayedRecipes = recipeNotifier.value
          .where((recipe) =>
              recipe.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hey $userName..!',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.10,
              color: Color.fromARGB(255, 142, 146, 143)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white10,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: const SideBarDrawer(),
      body: Column(
        children: [
          const SizedBox(height: 35),
          const Text(
            'What\'s in your kitchen..?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
            child: TextField(
              controller: searchController,
              onChanged: filterRecipes,
              decoration: InputDecoration(
                label: const Text('Search'),
                hintText: 'Search your recipes here..!',
                contentPadding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                suffixIcon: IconButton(
                  onPressed: () {
                    searchController.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ValueListenableBuilder(
                valueListenable: recipeNotifier,
                builder: (BuildContext ctx, List<recipeModel> recipeList,
                    Widget? child) {
                  return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 2
                          : 4,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: displayedRecipes.length,
                    itemBuilder: (context, index) {
                      final recipeDatas = displayedRecipes[index];
                      final reversedIndex = recipeList.length - 1 - index;
                      File? recipeImage;
                      if (recipeDatas.image != null) {
                        recipeImage = File(recipeDatas.image!);
                      }

                      return buildGridList(
                        context,
                        image: recipeImage,
                        icon: Icons.favorite_border_outlined,
                        text: recipeDatas.name,
                        category: recipeDatas.category,
                        description: recipeDatas.description,
                        ingredients: recipeDatas.ingredients,
                        cost: recipeDatas.cost,
                        editIcon: IconButton(
                          onPressed: () async {
                            final result = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditPageWidget(
                                  index: index,
                                  name: recipeDatas.name,
                                  category: recipeDatas.category,
                                  description: recipeDatas.description,
                                  ingredients: recipeDatas.ingredients,
                                  cost: recipeDatas.cost,
                                  image: recipeDatas.image,
                                ),
                              ),
                            );

                            if (result != null && result is recipeModel) {
                              updateRecipe(index, result);
                            }
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        deleteIcon: IconButton(
                          onPressed: () {
                            showDeleteConfirmationDialog(context, index);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        addToFavorite: () {
                          addToFavourite(recipeDatas);
                        },
                        onDelete: () {
                          deleteRecipies(reversedIndex);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
