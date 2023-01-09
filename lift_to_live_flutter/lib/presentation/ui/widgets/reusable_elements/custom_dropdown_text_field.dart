import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

import '../../../../helper.dart';

/// Custom Dropdown Text Field widget, which is nested in a form and used for receiving user input.
class CustomDropdownTextField extends StatelessWidget {
  final SingleValueDropDownController controller;
  final TextInputType textInputType;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final Function()? onTap;
  final Function(dynamic newValue)? onChanged;
  final List<String> items;
  final bool isEnabled;

  // Simple constructor for the log in form instance, which takes the context screen dimensions and the business logic object.
  const CustomDropdownTextField(
      {super.key,
      required this.controller,
      required this.textInputType,
      required this.hint,
      required this.icon,
      required this.obscureText,
      this.onTap,
      this.onChanged,
      required this.items,
      required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return SizedBox(
      child: DropDownTextField(
        dropDownList: items.map((String value) {
          return DropDownValueModel(value: value, name: value);
        }).toList(),
        textStyle: const TextStyle(color: Helper.whiteColor, fontSize: 15),
        controller: controller,
        onChanged: isEnabled ? onChanged : null,
        isEnabled: isEnabled,
        searchDecoration: InputDecoration(
            hintText: 'Search exercise',
            hintStyle: TextStyle(color: Helper.blackColor.withOpacity(0.3), fontSize: 15)),
        textFieldDecoration: InputDecoration(
          filled: true,
            fillColor: isEnabled ? Helper.lightBlueColor : Helper.blueColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Helper.whiteColor, width: 1, style: BorderStyle.solid),
            ),
            hintText: hint,
            hintStyle: const TextStyle(color: Helper.textFieldHintColor)),
        dropDownIconProperty: IconProperty(icon: icon, color: Helper.whiteColor),
        clearOption: isEnabled,
        enableSearch: true,
        clearIconProperty: IconProperty(color: Helper.whiteColor),
      ),
    );
  }
}
