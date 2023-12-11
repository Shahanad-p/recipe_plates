import 'package:flutter/material.dart';
import 'package:recipe_plates/category%20screen/beverages.dart';
import 'package:recipe_plates/category%20screen/desserts.dart';
import 'package:recipe_plates/category%20screen/fastfood.dart';
import 'package:recipe_plates/category%20screen/grilled.dart';
import 'package:recipe_plates/category%20screen/healthy.dart';
import 'package:recipe_plates/category%20screen/salads.dart';
import 'package:recipe_plates/category%20screen/snacks.dart';

class CategoryPageWidget extends StatefulWidget {
  const CategoryPageWidget({Key? key}) : super(key: key);

  @override
  State<CategoryPageWidget> createState() => _CategoryPageWidgetState();
}

class _CategoryPageWidgetState extends State<CategoryPageWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: buildAppBar(appBarName: 'Categories'),
        body: Center(
          child: listOfCategories(),
        ),
      ),
    );
  }

  Widget listOfCategories() => Center(
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BeveragesPage()));
              },
              child: buildCategoriesBox(
                category: 'Beverages',
                imagePath:
                    'assets/Image/vecteezy_ramadan-kareem-iftar-icon_22506749.png',
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FastfoodPage()));
              },
              child: buildCategoriesBox(
                category: 'Fastfood',
                imagePath:
                    'assets/Image/vecteezy_ramadan-kareem-iftar-icon_22506749.png',
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SaladsPage()));
              },
              child: buildCategoriesBox(
                category: 'Salads',
                imagePath:
                    'assets/Image/vecteezy_ramadan-kareem-iftar-icon_22506749.png',
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DessertsPage()));
              },
              child: buildCategoriesBox(
                category: 'Desserts',
                imagePath:
                    'assets/Image/red-cupcake-with-strawberries-and-cream-illustration-isolated-object-transparent-background-ai-generated-free-png.webp',
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HealthyPage()));
              },
              child: buildCategoriesBox(
                category: 'Healthy',
                imagePath:
                    'assets/Image/vecteezy_ramadan-kareem-iftar-icon_22506749.png',
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GrilledPage()));
              },
              child: buildCategoriesBox(
                category: 'Grilled',
                imagePath:
                    'assets/Image/vecteezy_ramadan-kareem-iftar-icon_22506749.png',
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SnacksPage()));
              },
              child: buildCategoriesBox(
                category: 'Snacks',
                imagePath:
                    'assets/Image/vecteezy_ramadan-kareem-iftar-icon_22506749.png',
              ),
            ),
          ],
        ),
      );

  AppBar buildAppBar({required String appBarName}) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white10,
      title: Text(
        appBarName,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  Widget buildCategoriesBox(
      {required String category, required String imagePath}) {
    double cardWidth = MediaQuery.of(context).size.width * 0.1;

    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      child: Container(
        height: 60,
        width: cardWidth,
        margin: const EdgeInsets.all(13.10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color.fromARGB(255, 222, 215, 215)),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 176, 194, 178),
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Image.asset(
                imagePath,
                height: 30,
                width: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
