// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:recipe_plates/main.dart';
import 'package:recipe_plates/screen/bottom_navigation.dart';
import 'package:recipe_plates/screen/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({super.key});

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  @override
  void initState() {
    CheckUserLoggedIn();
    super.initState();
  }

  Future goToLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPageWidget()));
  }

  Future<void> CheckUserLoggedIn() async {
    final sharedPref = await SharedPreferences.getInstance();
    final userLoggedIn = sharedPref.getBool(save_key_name);
    if (userLoggedIn == null || userLoggedIn == false) {
      goToLogin();
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const BottomNavBarWidget(userName: '')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image(
                image: AssetImage(
                  'assets/side-view-mushroom-frying-with-stove-spice-human-hand-pan (1).jpg',
                ),
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
