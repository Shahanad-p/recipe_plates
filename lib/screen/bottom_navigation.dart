import 'package:flutter/material.dart';
import 'package:recipe_plates/screen/add.dart';
import 'package:recipe_plates/screen/category_page.dart';
import 'package:recipe_plates/screen/favorite_page.dart';
import 'package:recipe_plates/screen/home.dart';
import 'package:recipe_plates/screen/pie_chart.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({super.key, required String username});

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  List pages = [
    HomePageWidget(
        // username: '',
        ),
    FavouritePageWidget(),
    const CategoryPageWidget(),
    PieChartPageWidget(),
  ];
  int currentIndexValue = 0;

  void onTap(int index) {
    setState(() {
      currentIndexValue = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndexValue],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(22.10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BottomNavigationBar(
            unselectedFontSize: 0,
            type: BottomNavigationBarType.fixed,
            onTap: onTap,
            backgroundColor: Color.fromARGB(24, 7, 100, 95),
            currentIndex: currentIndexValue,
            selectedItemColor: const Color.fromARGB(255, 9, 49, 83),
            unselectedItemColor: const Color.fromARGB(255, 145, 176, 239),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 25,
                ),
                label: 'ᴴᵒᵐᵉ',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_sharp,
                  size: 25,
                ),
                label: 'ᶠᵃᵛᵒᵘʳⁱᵗᵉ',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.bookmark,
                  size: 25,
                ),
                label: 'ᶜᵃᵗᵉᵍᵒʳʸ',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.donut_large_rounded,
                  size: 25,
                ),
                label: 'ᶜʰᵃʳᵗ',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 5,
          top: 25,
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddPageWidget(),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
