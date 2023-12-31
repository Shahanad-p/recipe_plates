import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_plates/functions/model/model.dart';
import 'package:recipe_plates/screen/bottom_navigation.dart';
import 'package:recipe_plates/screen/splash_screen.dart';
import 'package:recipe_plates/shared_preference.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(recipeModelAdapter().typeId)) {
    Hive.registerAdapter(recipeModelAdapter());
  }
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
