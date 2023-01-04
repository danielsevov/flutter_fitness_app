import 'package:flutter/material.dart';

import '../../../../helper.dart';

/// Custom Form Dropdown Text Field widget, which is nested in a form and used for receiving user input.
class CustomFormDropdownTextField extends StatelessWidget {
  final double screenHeight, // height of the context screen
      screenWidth; // width of the context screen
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final Function()? onTap;
  final Function(String? newValue) onChanged;
  final List<String> items;
  final bool isEnabled;

  // Simple constructor for the log in form instance, which takes the context screen dimensions and the business logic object.
  const CustomFormDropdownTextField(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.controller,
      this.validator,
      required this.textInputType,
      required this.hint,
      required this.icon,
      required this.obscureText,
      this.onTap,
      required this.onChanged,
      required this.items, required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return SizedBox(
      height: screenHeight * 0.1,
      width: screenWidth * 0.9,
      child: DropdownButtonFormField(
        items: items.map((String value) {
          return DropdownMenuItem(value: value, child: Text(value));
        }).toList(),
        onChanged: isEnabled ?  onChanged : null,
        value: controller.text,
        validator: (value) {
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.fitness_center,
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
              borderSide: const BorderSide(
                  color: Helper.textFieldBorderColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          hintText: hint,
          hintStyle: TextStyle(
              color: Helper.textFieldHintColor,
              fontSize: screenHeight / 35,
              height: 0.8),
        ),
        dropdownColor: Helper.blueColor,
        style: TextStyle(
            color: Helper.whiteColor,
            fontSize: screenHeight / 35,
            height: 0.8),
      ),
    );
  }
}
