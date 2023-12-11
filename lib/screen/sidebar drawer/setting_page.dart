import 'package:flutter/material.dart';

class SettingPageWidget extends StatelessWidget {
  const SettingPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        'Settings',
        style: TextStyle(color: Colors.black),
      ),
      elevation: 0,
      backgroundColor: Colors.white10,
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  Container buildBody() {
    return Container(
      padding: const EdgeInsets.all(40),
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
