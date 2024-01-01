import 'package:flutter/material.dart';
import 'package:recipe_plates/main.dart';
import 'package:recipe_plates/screen/bottom_navigation.dart';
import 'package:recipe_plates/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key});

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  final TextEditingController usernameController = TextEditingController();
  void checkLogin(BuildContext context) async {
    final userName = usernameController.text;

    if (userName.isNotEmpty) {
      final _sharedPref = await SharedPreferences.getInstance();
      await _sharedPref.setBool(save_key_name, true);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => BottomNavBarWidget(
            userName: userName,
          ),
        ),
      );
    } else {
      // print('Showing snackbar: Please enter a username');
      // print('Username entered: $userName');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          content: Text('Please enter a username'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 450,
              child: Stack(
                children: [
                  Positioned(
                    top: -40,
                    height: 420,
                    width: width,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/background.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    height: 420,
                    width: width + 20,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/background-2.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(
                        color: const Color.fromRGBO(196, 135, 198, .3),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(196, 135, 198, .3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromRGBO(196, 135, 198, .3),
                              ),
                            ),
                          ),
                          child: TextFormField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Username",
                              hintStyle: TextStyle(
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  MaterialButton(
                    onPressed: () {
                      checkLogin(context);
                    },
                    color: const Color.fromRGBO(49, 39, 79, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.10),
                    ),
                    height: 50,
                    child: const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
