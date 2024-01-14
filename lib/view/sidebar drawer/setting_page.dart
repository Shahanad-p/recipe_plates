import 'package:flutter/material.dart';

class SettingPageWidget extends StatelessWidget {
  const SettingPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Container(
          padding: const EdgeInsets.all(40.10),
          child: ListView(
            children: [
              buildSection('Profile', Icons.person),
              buildDivider(),
              buildSection('Notification', Icons.notifications),
              buildDivider(),
              buildSection('Security', Icons.security),
              buildDivider(),
              buildSection('Account', Icons.person),
              buildDivider(),
              buildSection('Support', Icons.support),
              buildDivider(),
              buildSection('Mode', Icons.mode),
              buildDivider(),
            ],
          ),
        ),
      ),
    );
  }

  Column buildSection(
    String title,
    IconData iconData,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Icon(iconData),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Divider buildDivider() {
    return const Divider(
      height: 30,
      thickness: 1,
    );
  }
}
