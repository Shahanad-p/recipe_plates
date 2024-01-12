import 'dart:io';
import 'package:flutter/material.dart';

class MenuOpeningPage extends StatelessWidget {
  final String name;
  final String category;
  final String description;
  final String ingredients;
  final String cost;
  final File selectedImagePath;
  const MenuOpeningPage({
    required this.name,
    required this.category,
    required this.description,
    required this.ingredients,
    required this.cost,
    required this.selectedImagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Menu',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: buildItems(
          selectedImagePath,
          name,
          category,
          description,
          ingredients,
          cost,
        ),
      ),
    );
  }

  Widget buildItems(
    File image,
    String nameText,
    String categoryText,
    String descriptionText,
    String ingredientsText,
    String costText,
  ) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 210,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(18),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.file(
                image,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            nameText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Divider(),
          const SizedBox(height: 28),
          Text(
            categoryText,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const Divider(),
          const SizedBox(height: 28),
          Text(
            descriptionText,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const Divider(),
          const SizedBox(height: 28),
          Text(
            ingredientsText,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const Divider(),
          const SizedBox(height: 28),
          Text(
            '₹: $costText',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
