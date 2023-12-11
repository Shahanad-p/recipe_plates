import 'package:flutter/material.dart';
import 'package:recipe_plates/screen/bottom_navigation.dart';


class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildLoginPage(),
    );
  }

  Widget buildLoginPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            controller: usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              hintText: 'Enter your username here',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15),
                  bottom: Radius.circular(15),
                ),
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Get the entered username
            String username = usernameController.text;

            // Check if username is not empty (you can add more validation as needed)

            // Navigate to the HomePageWidget with the entered username
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavBarWidget(username: username),
              ),
            );
          },
          child: const Text(
            'Login Now',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar() => AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        centerTitle: true,
      );
}