import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_plates/functions/model/model.dart';
import 'package:recipe_plates/screen/splash_screen.dart';
import 'package:recipe_plates/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(recipeModelAdapter().typeId)) {
    Hive.registerAdapter(recipeModelAdapter());
  }

  // Initialize SharedPreferences
  await SharedPreferenceServices.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenWidget(),
    );
  }
}
