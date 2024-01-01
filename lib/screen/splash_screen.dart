// ignore_for_file: use_build_context_synchronously

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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

  @override
  void dispose() {
    super.dispose();
  }

  Future goToLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPageWidget()));
  }

  Future<void> CheckUserLoggedIn() async {
    final _sharedPref = await SharedPreferences.getInstance();
    final _userLoggedIn = _sharedPref.getBool(save_key_name);
    // final userName = _sharedPref.getString('username') ?? '';
    if (_userLoggedIn == null || _userLoggedIn == false) {
      goToLogin();
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const BottomNavBarWidget(userName: '')));
    }
  }
}
