import 'package:flutter/material.dart';

class HelpPageWidget extends StatelessWidget {
  const HelpPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: ListView(
          children: [
            buildHelpItem(Icons.help_outline_outlined, 'Help Centre'),
            buildDivider(),
            buildHelpItem(Icons.description_outlined, 'Terms & Privacy Policy'),
            buildDivider(),
            buildHelpItem(Icons.call, 'Contact us'),
            buildDivider(),
            buildHelpItem(Icons.info_outline, 'App info'),
            buildDivider(),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        'Help',
        style: TextStyle(color: Colors.black),
      ),
      elevation: 0,
      backgroundColor: Colors.white10,
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  Widget buildHelpItem(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 13),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget buildDivider() {
    return const Divider(
      thickness: 1,
      height: 25,
    );
  }
}
