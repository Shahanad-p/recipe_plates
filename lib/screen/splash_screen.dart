import 'package:flutter/material.dart';
import 'package:recipe_plates/screen/login_page.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({super.key});

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  @override
  void initState() {
    super.initState();
    // Delay for 3 seconds and then navigate to the login screen
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPageWidget(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image(
            image: AssetImage(
              'assets/side-view-mushroom-frying-with-stove-spice-human-hand-pan (1).jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
