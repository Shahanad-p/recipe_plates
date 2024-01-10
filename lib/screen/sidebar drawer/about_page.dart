import 'package:flutter/material.dart';

class AboutPageWidget extends StatelessWidget {
  const AboutPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'About',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.all(40),
          child: ListView(
            children: [
              buildSection('About us', [
                'Welcome to the Recipe plate App, your ultimate cooking companion. We are passionate about bringing you delicious recipes from around the world. Our mission is to inspire your culinary adventures and make cooking a delightful experience.',
              ]),
              buildDivider(),
              buildSection('App information', [
                '• App Name : Recipe Plate',
                '• Version: 1.0.0+1',
              ]),
              buildDivider(),
              buildSection('Features', [
                '• Explore a vast collection of recipes.',
                '• Save your favorite recipes for easy access.',
                '• Create shopping lists for your next cooking adventure.',
              ]),
              buildDivider(),
              buildSection('Contact us', [
                'If you have any questions, feedback, or suggestions, please feel free to reach out to us.',
                '• Email : shahanadp21@gmail.com',
                '• Phone : 9645347463',
              ]),
              buildDivider(),
              buildSection('Developed By', [
                'Recipe Plate App is proudly developed by Muhammed Shahanad PP. Thank you for choosing our app to enhance your cooking journey!',
              ]),
              buildDivider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSection(String heading, List content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeading(heading),
        buildSpacing(10),
        ...content.map((text) => buildText(text)),
        buildSpacing(30),
      ],
    );
  }

  Widget buildHeading(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget buildText(String text) {
    return Text(text);
  }

  Widget buildSpacing(double height) {
    return SizedBox(height: height);
  }

  Widget buildDivider() {
    return const Divider(
      thickness: 1,
      height: 25,
    );
  }
}
