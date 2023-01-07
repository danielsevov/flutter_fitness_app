import 'package:flutter/material.dart';

import '../../../../helper.dart';

/// Custom Form Text Field widget, which is nested in a form and used for receiving user input.
class CustomFormTextField extends StatelessWidget {
  final double screenHeight, // height of the context screen
      screenWidth; // width of the context screen
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final Function()? onTap;

  // Simple constructor for the log in form instance, which takes the context screen dimensions and the business logic object.
  const CustomFormTextField(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.controller,
      this.validator,
      required this.textInputType,
      required this.hint,
      required this.icon,
      required this.obscureText,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return SizedBox(
      //height: screenHeight * 0.075,
      width: screenWidth * 0.85,
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        obscureText: obscureText,
        validator: validator,
        textAlign: TextAlign.center,
        keyboardType: textInputType,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Helper.textFieldIconColor,
          ),
          filled: true,
          fillColor: Helper.blueColor,
          errorStyle: const TextStyle(color: Helper.textFieldErrorColor),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Helper.textFieldBorderColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Helper.textFieldErrorColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Helper.textFieldErrorColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Helper.textFieldBorderColor.withOpacity(0.3), width: 1),
              borderRadius: BorderRadius.circular(10)),
          hintText: hint,
          hintStyle: const TextStyle(
              color: Helper.textFieldHintColor,
              fontSize: 20,
              height: 0.8),
        ),
        style: const TextStyle(
            color: Helper.textFieldTextColor,
            fontSize: 20,
            height: 0.8),
      ),
    );
  }
}
