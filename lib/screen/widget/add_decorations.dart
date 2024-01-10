import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

Widget buildTextFormField(TextEditingController controller, String label,
    String hintText, double height, String? Function(String?)? validator,
    {bool numericOnly = false}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: controller,
      keyboardType: numericOnly ? TextInputType.number : null,
      inputFormatters:
          numericOnly ? [FilteringTextInputFormatter.digitsOnly] : null,
      maxLines: null,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
            top: Radius.circular(25),
          ),
        ),
        labelText: label,
        hintText: hintText,
        contentPadding: EdgeInsets.only(
          top: height / 2 - 16,
          bottom: height / 2 - 16,
          left: 25,
        ),
      ),
      validator: validator,
    ),
  );
}

GestureDetector buildImageSelectionOption(
    String iconPath, String label, Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Lottie.asset(
              iconPath,
              height: 50,
              width: 50,
            ),
            Text(label),
          ],
        ),
      ),
    ),
  );
}
