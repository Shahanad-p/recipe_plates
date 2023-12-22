import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_plates/functions/functions/functions.dart';
import 'package:recipe_plates/functions/model/model.dart';
import 'package:recipe_plates/screen/edit_page.dart';
import 'package:recipe_plates/screen/menu.dart';
import 'package:recipe_plates/screen/sidebar_drawer.dart';

class HomePageWidget extends StatefulWidget {
  final String username;
  const HomePageWidget({super.key, required this.username});

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  List<recipeModel> displayedRecipes = [];
  TextEditingController searchController = TextEditingController();

  void filterRecipes(String query) {
    setState(() {
      displayedRecipes = recipeNotifier.value
          .where((recipe) =>
              recipe.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getAllRecipiesByList();
    displayedRecipes = recipeNotifier.value;
  }

  Future<void> showDeleteConfirmationDialog(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text(
                  'Are you sure you want to delete this recipe?',
                  style: TextStyle(fontSize: 18),
                ),
                Lottie.asset('assets/Animation - 1702529005450.json',
                    height: 60),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green),
              ),
              onPressed: () {
                deleteRecipies(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> addToFavourite(recipeModel data) async {
    final cartdb = await Hive.openBox<recipeModel>('favorite_db');

    // Check if the recipe is not already in the favorites
    if (!cartitems.contains(data)) {
      cartitems.add(data);
      cartdb.add(data);
      // recipeNotifier.notifyListeners();
      getAllRecipiesByList();
    }
  }

  Future<void> deleteFromFavourite(int index) async {
    final cartdb = await Hive.openBox<recipeModel>('favorite_db');
    cartdb.deleteAt(index);
    cartitems.removeAt(index);
    getAllRecipiesByList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hey ${widget.username}..!',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
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
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
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
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                              builder: (context) => EditPageWidget(
                                index: index,
                                name: recipeDatas.name,
                                category: recipeDatas.category,
                                description: recipeDatas.description,
                                ingredients: recipeDatas.ingredients,
                                cost: recipeDatas.cost,
                                image: recipeDatas.image,
                              ),
                            ))
                                .then((result) {
                              if (result != null && result is recipeModel) {
                                // Handle the updated recipe
                                updateRecipe(index, result);
                              }
                            });
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        deleteIcon: IconButton(
                          onPressed: () {
                            showDeleteConfirmationDialog(index);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        addToCart: () {
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
    required VoidCallback addToCart,
    required VoidCallback onDelete,
  }) {
    double cardWidth = MediaQuery.of(context).size.width *
        (MediaQuery.of(context).orientation == Orientation.portrait
            ? 0.4
            : 0.2);
    double cardHeight = 150.0;

    return Padding(
      padding: EdgeInsets.all(
        MediaQuery.of(context).size.width * 0.01,
      ),
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
                    Positioned(
                      top: 2.0,
                      right: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: addToCart,
                          icon: const Icon(Icons.favorite_outline),
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
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                offset: Offset(1, 1),
                                blurRadius: 1,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          category!,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 10, 65, 12),
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                offset: Offset(1, 1),
                                blurRadius: 1,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '₹: ${cost.toString()}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                offset: Offset(1, 1),
                                blurRadius: 1,
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

  void updateRecipe(int index, recipeModel updatedRecipe) {
    setState(() {
      displayedRecipes[index] = updatedRecipe;
    });
  }
}
