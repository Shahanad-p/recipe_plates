import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_plates/db/functions/functions.dart';
import 'package:recipe_plates/db/mode/model.dart';
import 'package:recipe_plates/screen/menu.dart';
import 'package:recipe_plates/screen/sidebar_drawer.dart';
import 'package:recipe_plates/screen/update_page.dart';

class HomePageWidget extends StatefulWidget {
  final recipeList = recipeNotifier.value;
  HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

@override
class _HomePageWidgetState extends State<HomePageWidget> {
  final ImagePicker _imagePicker = ImagePicker();
  TextEditingController searchController = TextEditingController();
  List<recipeModel> foodRecipetList = [];

  @override
  void initState() {
    super.initState();

    // loadstd();
    getAllRecipiesByList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: const SideBarDrawer(),
      body: Column(
        children: [
          const Text(
            'What\'s in your kitchen..?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                label: const Text('Search'),
                hintText: 'Search your recipies here..!',
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
                    itemCount: recipeList.length,
                    itemBuilder: (context, index) {
                      final recipeDatas = recipeList[index];
                      final reversedIndex = recipeList.length - 1 - index;
                      final data = recipeList[reversedIndex];
                      // final addData=hive;
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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UpdatePageWidget(
                                        index: index,
                                        name: data.name,
                                        category: data.category,
                                        description: data.description,
                                        ingredients: data.ingredients,
                                        cost: data.cost,
                                        image: data.image,
                                      )));
                            },
                            icon: const Icon(Icons.edit)),
                        deleteIcon: IconButton(
                          onPressed: () {
                            deleteRecipies(index);
                          },
                          icon: const Icon(
                            Icons.delete,
                          ),
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
