import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_plates/db/mode/model.dart';

final _imagePicker = ImagePicker();
final nameController = TextEditingController();
final categoryController = TextEditingController();
final descriptionController = TextEditingController();
final ingredientsController = TextEditingController();
final costController = TextEditingController();
final _formKey = GlobalKey<FormState>();
String? image;
String selectCategory = 'Beverages';
final List<String> _categoryList = [
  'Beverages',
  'Fastfood',
  'Salads',
  'Desserts',
  'Healthy',
  'Grilled',
  'Snacks'
];

class UpdatePageWidget extends StatefulWidget {
  final String name;
  final String category;
  final String description;
  final String ingredients;
  final int index;
  final String cost;
  dynamic image;

  UpdatePageWidget({
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
  State<UpdatePageWidget> createState() => _UpdatePageWidgetState();
}

class _UpdatePageWidgetState extends State<UpdatePageWidget> {
  @override
  void initState() {
    // TODO: implement initState
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
      appBar: buildAppBar(appBarName: 'Edit your recipies'),
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
        child: Form(
          child: Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    await editimage();
                    setState(() {});
                  },
                  child: buildRecipeImage(),
                ),
                const SizedBox(height: 20.0),
                buildRecipeForm(),
                const SizedBox(height: 10),
                UpdatedButton(),
              ],
            ),
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
              return 'Name is required';
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
              return 'Description is required';
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
              return 'Ingredients are required';
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
              return 'Total cost is required';
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

  Widget UpdatedButton() {
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
        if (_formKey.currentState!.validate()) {
          final newRecipe = recipeModel(
            name: nameController.text,
            category: categoryController.text,
            description: descriptionController.text,
            ingredients: ingredientsController.text,
            cost: costController.text,
            image: image,
          );
          updateRecipe(context);
          Navigator.of(context).pop();
        } else {
          debugPrint('Please fix the errors before submitting.');
        }
      },
      child: const Text('Update Recipies'),
    );
  }

  Future<void> editimage() async {
    final returnImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (returnImage != null) {
      return setState(() {
        image = returnImage.path;
      });
    }
    Navigator.pop(context);
  }

  Future<void> imageEditCam() async {
    final returnImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (returnImage != null) {
      return setState(() {
        image = returnImage.path;
      });
    }
    Navigator.pop(context);
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
            return 'Category is required';
          }
          return null;
        },
      ),
    );
  }

  Future<void> updateRecipe(BuildContext context) async {
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
      debugPrint('Please fill in all fields');
      return;
    }
  }
}
