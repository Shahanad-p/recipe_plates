import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_plates/functions/functions/functions.dart';
import 'package:recipe_plates/functions/model/model.dart';
import 'package:recipe_plates/view/widget/add_decorations.dart';

class AddPageWidget extends StatefulWidget {
  const AddPageWidget({Key? key}) : super(key: key);

  @override
  State<AddPageWidget> createState() => _AddPageWidgetState();
}

class _AddPageWidgetState extends State<AddPageWidget> {
  final ImagePicker _imagePicker = ImagePicker();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _costController = TextEditingController();
  File? _image;
  final _formKey = GlobalKey<FormState>();
  String _selectedCategory = 'Beverages';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'New Recipe',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _selectImageDialog,
                    child: _buildRecipeImage(),
                  ),
                  const SizedBox(height: 20),
                  _buildTextFormField(
                    _nameController,
                    'Name',
                    'Enter your recipe name',
                    (value) => _validateField(value, 'Name is required'),
                  ),
                  const SizedBox(height: 10),
                  _buildCategoryDropdown(),
                  const SizedBox(height: 10),
                  _buildTextFormField(
                    _descriptionController,
                    'Description',
                    'Enter your recipe description here',
                    (value) => _validateField(value, 'Description is required'),
                  ),
                  const SizedBox(height: 10),
                  _buildTextFormField(
                    _ingredientsController,
                    'Ingredients',
                    'Enter your recipe ingredients',
                    (value) =>
                        _validateField(value, 'Ingredients are required'),
                  ),
                  const SizedBox(height: 10),
                  _buildTextFormField(
                    _costController,
                    'Total cost',
                    'Enter your recipe total cost',
                    (value) => _validateField(value, 'Total cost is required'),
                    numericOnly: true,
                  ),
                  const SizedBox(height: 10),
                  _buildAddButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecipeImage() {
    return _image != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.file(
              _image!,
              height: 150,
              width: 220,
              fit: BoxFit.fill,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              'assets/2947690.jpg',
              height: 150,
              width: 220,
              fit: BoxFit.fill,
            ),
          );
  }

  Widget _buildTextFormField(TextEditingController controller, String label,
      String hintText, FormFieldValidator<String> validator,
      {bool numericOnly = false}) {
    return buildTextFormField(
      controller,
      label,
      hintText,
      80.10,
      validator,
      numericOnly: numericOnly,
    );
  }

  Widget _buildCategoryDropdown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        value: _selectedCategory,
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
              _selectedCategory = value;
            });
          }
        },
        validator: (value) => _validateField(value, 'Category is required'),
      ),
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.amber),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.2,
          ),
        ),
        textStyle: MaterialStateProperty.all(
          const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          addButtonClicked();
        } else {
          debugPrint('Please fix the errors before submitting.');
        }
      },
      child: const Text('Add all recipes'),
    );
  }

  Future<void> _selectImageDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const Text(
                    'Select Image From !',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildImageSelectionOption(
                        'assets/Animation - 1701430677440.json',
                        'Gallery',
                        selectedImageFromGallery,
                      ),
                      buildImageSelectionOption(
                        'assets/Animation - 1702530000704.json',
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
      },
    );
    setState(() {});
  }

  Future<void> selectedImageFromGallery() async => _setImage(await _imagePicker
      .pickImage(source: ImageSource.gallery, imageQuality: 10));

  Future<void> selectedImageFromCamera() async => _setImage(await _imagePicker
      .pickImage(source: ImageSource.camera, imageQuality: 10));

  void _setImage(XFile? file) {
    if (file != null) {
      setState(() {
        _image = File(file.path);
      });
    }
    Navigator.pop(context);
  }

  void addButtonClicked() {
    final name = _nameController.text.trim();
    final category = _selectedCategory.trim();
    final description = _descriptionController.text.trim();
    final ingredients = _ingredientsController.text.trim();
    final cost = _costController.text.trim();

    if ([name, category, description, ingredients, cost, _image]
        .any((value) => value == null || value.toString().isEmpty)) {
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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully added new recipe.!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String? _validateField(String? value, String errorMessage) =>
      value?.isEmpty ?? true ? errorMessage : null;
}
