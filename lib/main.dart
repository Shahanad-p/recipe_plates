// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_plates/functions/model/model.dart';
import 'package:recipe_plates/screen/splash_screen.dart';

const save_key_name = 'UserLoggedIn';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  if (!Hive.isAdapterRegistered(recipeModelAdapter().typeId)) {
    Hive.registerAdapter(recipeModelAdapter());
  }

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
