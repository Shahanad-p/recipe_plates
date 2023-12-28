import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_plates/functions/functions/functions.dart';
import 'package:recipe_plates/functions/model/model.dart';
import 'package:recipe_plates/screen/edit_page.dart';
import 'package:recipe_plates/screen/login_page.dart';
import 'package:recipe_plates/screen/menu.dart';
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
  void dispose() {
    super.dispose();
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

  @override
  void initState() {
    super.initState();
    getData();
    getAllRecipiesByList();
    displayedRecipes = recipeNotifier.value;
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

  Future<void> showDeleteConfirmationDialog(int index) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                const Text(
                  'Are you sure you want to delete this recipe?',
                  style: TextStyle(fontSize: 18),
                ),
                Lottie.asset('assets/Animation - 1702529005450.json',
                    height: 60),
              ],
            ),
          ),
          actions: [
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

  void _exitApp() {
    SystemNavigator.pop();
  }

  @override
  build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _exitApp();
        return false;
      },
      child: Scaffold(
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
                              final result = await Navigator.of(context)
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
                              ));

                              if (result != null && result is recipeModel) {
                                updateRecipe(index, result);
                              }
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          deleteIcon: IconButton(
                            onPressed: () {
                              showDeleteConfirmationDialog(index);
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
    required VoidCallback addToFavorite,
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
              offset: Offset(5.0, 5.0),
              blurRadius: 0,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color.fromARGB(255, 255, 255, 255),
              blurRadius: 0,
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
                Positioned(
                  top: 2.0,
                  right: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: addToFavorite,
                      icon: const Icon(Icons.favorite_outline),
                    ),
                  ),
                ),
                Positioned(
                  top: 2.0,
                  right: 50.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: deleteIcon!,
                  ),
                ),
                Positioned(
                  top: 2.0,
                  left: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: editIcon!,
                  ),
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
}
