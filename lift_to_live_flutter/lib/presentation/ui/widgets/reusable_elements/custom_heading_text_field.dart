import 'package:flutter/material.dart';

import '../../../../helper.dart';

/// Custom Heading Text Field widget, which is nested in a form and used for receiving user input.
class CustomHeadingTextField extends StatelessWidget {
  final double screenHeight, // height of the context screen
      screenWidth; // width of the context screen
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final String hint;
  final IconData icon;
  final Color color;
  final Function()? onTap;
  final bool isHeadline;

  // Simple constructor for the log in form instance, which takes the context screen dimensions and the business logic object.
  const CustomHeadingTextField(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.controller,
      this.validator,
      required this.textInputType,
      required this.hint,
      required this.icon,
      this.onTap, required this.color, required this.isHeadline});

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return SizedBox(
      //height: screenHeight * 0.075,
      width: screenWidth * 0.95,
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        validator: validator,
        textAlign: TextAlign.center,
        keyboardType: textInputType,
        maxLines: 10,
        minLines: 1,
        maxLength: isHeadline ? 25 : 500,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: color,
          ),
          filled: true,
          fillColor: Helper.blueColor,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: color, width: 1),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: color, width: 1),
              borderRadius: BorderRadius.circular(10)),
          hintText: hint,
          hintStyle: const TextStyle(
              color: Helper.textFieldHintColor,
              fontSize: 20,
              height: 0.8),
        ),
        style: TextStyle(
            color: color,
            fontSize: 20,
            height: 0.8),
      ),
    );
  }
}
