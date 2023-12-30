import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe_plates/screen/menu.dart';

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
      (MediaQuery.of(context).orientation == Orientation.portrait ? 0.4 : 0.2);
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
          ]),
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
                      ))),
              Positioned(
                  top: 2.0,
                  right: 50.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: deleteIcon!,
                  )),
              Positioned(
                  top: 2.0,
                  left: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: editIcon!,
                  )),
              Positioned(
                bottom: 35,
                left: 35,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(text!,
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
                                )
                              ])),
                      const SizedBox(height: 3),
                      Text(category!,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 10, 65, 12),
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.white,
                                  offset: Offset(1, 1),
                                  blurRadius: 1,
                                )
                              ])),
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
