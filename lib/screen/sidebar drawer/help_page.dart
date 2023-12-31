import 'package:flutter/material.dart';

class HelpPageWidget extends StatelessWidget {
  const HelpPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.10),
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
