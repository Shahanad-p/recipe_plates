import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_plates/db/functions/functions.dart';
import 'package:recipe_plates/db/mode/model.dart';
import 'package:recipe_plates/screen/home.dart';

class AddPageWidget extends StatefulWidget {
  const AddPageWidget({Key? key}) : super(key: key);

  @override
  State<AddPageWidget> createState() => _AddPageWidgetState();
}

class _AddPageWidgetState extends State<AddPageWidget> {
  final _imagePicker = ImagePicker();
  final ImagePicker image = ImagePicker();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _costController = TextEditingController();
  File? _image;
  final _formKey = GlobalKey<FormState>();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(appBarName: 'New Recipe'),
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
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    await selectImage();
                    setState(() {});
                  },
                  child: buildRecipeImage(),
                ),
                const SizedBox(height: 20.0),
                buildRecipeForm(),
                const SizedBox(height: 10),
                buildAddButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRecipeImage() {
    return _image != null ? buildDefaultRecipeImage() : buildPlaceholderImage();
  }

  Widget buildPlaceholderImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Image.asset(
        'assets/Image/restaurant-food-frame-with-rustic-wood-background-free-93.jpg',
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
        _image!,
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
          _nameController,
          'Name',
          'Enter your recipe name',
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
          _descriptionController,
          'Description',
          'Enter your recipe description here',
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
          _ingredientsController,
          'Ingredients',
          'Enter your recipe ingredients',
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
          _costController,
          'Total cost',
          'Enter your recipe total cost',
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

  Widget buildAddButton() {
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
          addButtonClicked(context);
        } else {
          debugPrint('Please fix the errors before submitting.');
        }
      },
      child: const Text('Add all recipies'),
    );
  }

  Future selectImage() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return buildImageSelectionDialog();
      },
    );
  }

  Widget buildImageSelectionDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.10)),
      child: Container(
        width: 150,
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Text(
                'Select Image From !',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildImageSelectionOption(
                    'assets/Image/Animation - 1701430677440.json',
                    'Gallery',
                    selectedImageFromGallery,
                  ),
                  buildImageSelectionOption(
                    'assets/Image/Animation - 1701430745712.json',
                    'Camera',
                    selectedImageFromCamera,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buildImageSelectionOption(
      String iconPath, String label, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Lottie.asset(
                iconPath,
                height: 50,
                width: 50,
              ),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectedImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      setState(() {
        _image = File(file.path);
      });
    }
    Navigator.pop(context);
  }

  Future<void> selectedImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      setState(() {
        _image = File(file.path);
      });
    }
    Navigator.pop(context);
  }

  Future<void> addButtonClicked(BuildContext context) async {
    final name = _nameController.text.trim();
    final category = selectCategory.trim();
    final description = _descriptionController.text.trim();
    final ingredients = _ingredientsController.text.trim();
    final cost = _costController.text.trim();

    if (name.isEmpty ||
        category.isEmpty ||
        description.isEmpty ||
        ingredients.isEmpty ||
        cost.isEmpty ||
        _image == null) {
      debugPrint('Please fill in all fields');
      return;
    }

    final recipe = recipeModel(
      name: name,
      category: category,
      description: description,
      ingredients: ingredients,
      cost: cost,
      image: _image?.path,
    );

    addRecipies(recipe);

    Navigator.of(context).pop(recipe);

    _nameController.clear();
    _descriptionController.clear();
    _ingredientsController.clear();
    _costController.clear();
    setState(() {
      _image = null;
    });
  }
}
