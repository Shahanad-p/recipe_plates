import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_plates/functions/model/model.dart';

final _imagePicker = ImagePicker();
final nameController = TextEditingController();
final categoryController = TextEditingController();
final descriptionController = TextEditingController();
final ingredientsController = TextEditingController();
final costController = TextEditingController();
String? image;

String selectCategory = 'Beverages';
final List<String> _categoryList = [
  'Beverages',
  'Fastfood',
  'Salads',
  'Desserts',
  'Healthy',
  'Grilled',
  'Snacks',
  'Soup'
];

class EditPageWidget extends StatefulWidget {
  final String name;
  final String category;
  final String description;
  final String ingredients;
  final int index;
  final String cost;
  dynamic image;

  EditPageWidget({
    super.key,
    required this.name,
    required this.category,
    required this.description,
    required this.ingredients,
    required this.index,
    required this.cost,
    required this.image,
  });

  @override
  State<EditPageWidget> createState() => _EditPageWidgetState();
}

class _EditPageWidgetState extends State<EditPageWidget> {
  @override
  void initState() {
    super.initState();

    nameController.text = widget.name;
    categoryController.text = widget.category;
    descriptionController.text = widget.description;
    ingredientsController.text = widget.ingredients;
    costController.text = widget.cost;
    image = widget.image != '' ? widget.image : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(appBarName: 'Edit your recipes'),
      body: buildBody(),
    );
  }

  AppBar buildAppBar({required String appBarName}) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white10,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(
        appBarName,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  await editImage();
                  setState(() {});
                },
                child: buildRecipeImage(),
              ),
              const SizedBox(height: 20.0),
              buildRecipeForm(),
              const SizedBox(height: 10),
              buildUpdateButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRecipeImage() {
    return image != null ? buildDefaultRecipeImage() : buildPlaceholderImage();
  }

  Widget buildPlaceholderImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Image.asset(
        'assets/restaurant-food-frame-with-rustic-wood-background-free-93.jpg',
        height: 150,
        width: 220,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget buildDefaultRecipeImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Image.file(
        image != null ? File(image!) : File(''),
        height: 150,
        width: 220,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget buildRecipeForm() {
    return Column(
      children: [
        buildTextFormField(
          nameController,
          'Name',
          'Edit recipe name',
          80.10,
          (value) {
            if (value == null || value.isEmpty) {
              return null;
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        buildCategoryDropdown(),
        const SizedBox(height: 10),
        buildTextFormField(
          descriptionController,
          'Description',
          'Edit recipe description',
          80.10,
          (value) {
            if (value == null || value.isEmpty) {
              return null;
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        buildTextFormField(
          ingredientsController,
          'Ingredients',
          'Edit recipe ingredients',
          80.10,
          (value) {
            if (value == null || value.isEmpty) {
              return null;
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        buildTextFormField(
          costController,
          'Total cost',
          'Edit recipe cost',
          80.10,
          (value) {
            if (value == null || value.isEmpty) {
              return null;
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget buildTextFormField(
    TextEditingController controller,
    String label,
    String hintText,
    double height,
    String? Function(String?)? validator,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        maxLines: null,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
              top: Radius.circular(25),
            ),
          ),
          labelText: label,
          hintText: hintText,
          contentPadding: EdgeInsets.only(
            top: height / 2 - 16,
            bottom: height / 2 - 16,
            left: 25,
          ),
        ),
        validator: validator,
      ),
    );
  }

  Widget buildUpdateButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.amber),
        padding: MaterialStateProperty.all(
          const EdgeInsets.only(left: 35, right: 35),
        ),
        textStyle: MaterialStateProperty.all(
          const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      onPressed: () {
        recipeUpdate(context);
        // Navigator.of(context).pop();
      },
      child: const Text('Update Recipes'),
    );
  }

  Future<void> editImage() async {
    try {
      final returnImage = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 10,
      );
      if (returnImage != null) {
        setState(() {
          image = returnImage.path;
        });
      }
    } catch (e) {
      print('Image picker exception: $e');
    }
    // Navigator.pop(context);
  }

  Widget buildCategoryDropdown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        value: selectCategory,
        itemHeight: 50.0,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
              top: Radius.circular(25),
            ),
          ),
          labelText: 'Categories',
          contentPadding: EdgeInsets.only(left: 25),
        ),
        items: _categoryList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          if (value != null) {
            setState(() {
              selectCategory = value;
            });
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return null;
          }
          return null;
        },
      ),
    );
  }

  Future<void> recipeUpdate(BuildContext context) async {
    final name = nameController.text.trim();
    final category = selectCategory.trim();
    final description = descriptionController.text.trim();
    final ingredients = ingredientsController.text.trim();
    final cost = costController.text.trim();

    if (name.isEmpty ||
        category.isEmpty ||
        description.isEmpty ||
        ingredients.isEmpty ||
        cost.isEmpty ||
        image == null) {
      return;
    }

    final updatedRecipe = recipeModel(
      name: name,
      category: category,
      description: description,
      ingredients: ingredients,
      cost: cost,
      image: image,
    );

    Navigator.of(context).pop(updatedRecipe);
  }
}