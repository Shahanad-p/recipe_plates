// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class SearchPageWidget extends StatefulWidget {
//   SearchPageWidget({Key? key, required String username}) : super(key: key);

//   @override
//   State<SearchPageWidget> createState() => _SearchPageWidgettState();
// }

// class _SearchPageWidgettState extends State<SearchPageWidget> {
//   TextEditingController searchController = TextEditingController();
//   final ImagePicker _imagePicker = ImagePicker();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Center(
//             child: Column(
//               children: [
//                 nameTextBuilder(
//                   'What\'s in your kitchen..?',
//                   'Enter any ingredients',
//                 ),
//                 const SizedBox(height: 20),
//                 buildCircularTextField(),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget nameTextBuilder(String text1, String text2) {
//     return Column(
//       children: [
//         SizedBox(height: MediaQuery.of(context).size.height * 0.05),
//         Text(
//           text1,
//           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         Text(text2)
//       ],
//     );
//   }

//   Widget buildCircularTextField() {
//     return Padding(
//       padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
//       child: TextField(
//         controller: searchController,
//         decoration: InputDecoration(
//           hintText: 'Search...',
//           contentPadding: EdgeInsets.symmetric(
//               horizontal: MediaQuery.of(context).size.width * 0.1),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
//           suffixIcon: IconButton(
//             onPressed: () {
//               searchController.clear();
//             },
//             icon: const Icon(Icons.clear),
//           ),
//         ),
//       ),
//     );
//   }

//   // Future<void> _pickImage() async {
//   //   final XFile? pickedImage =
//   //       await _imagePicker.pickImage(source: ImageSource.gallery);

//   //   if (pickedImage != null) {
//   //     setState(() {
//   //       recipeListNotifier.value = [
//   //         ...recipeListNotifier.value,
//   //         RecipePlateModel(
//   //           name: '',
//   //           category: '',
//   //           description: '',
//   //           ingredients: '',
//   //           cost: '',
//   //           selectedImagePath: null,
//   //         ),
//   //       ];
//   //     });
//   //   }
//   // }
// }
