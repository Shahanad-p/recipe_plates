// import 'package:flutter/material.dart';
// import 'package:recipe_plates/main.dart';
// import 'package:recipe_plates/screen/bottom_navigation.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// final usernameController = TextEditingController();

// void checkLogin(BuildContext context) async {
//   final userName = usernameController.text;

//   if (userName.isNotEmpty) {
//     final _sharedPref = await SharedPreferences.getInstance();
//     await _sharedPref.setBool(save_key_name, true);

//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: (context) => BottomNavBarWidget(
//           userName: userName,
//         ),
//       ),
//     );
//   } else {
//     print('Showing snackbar: Please enter a username');
//     print('Username entered: $userName');
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         backgroundColor: Colors.red,
//         behavior: SnackBarBehavior.floating,
//         duration: Duration(seconds: 2),
//         content: Text('Please enter a username'),
//       ),
//     );
//   }
// }
