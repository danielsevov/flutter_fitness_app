import 'package:flutter/material.dart';

import '../../../../helper.dart';

/// Custom Form button widget, which is nested in a form and used for submitting the user input.
class CustomFormButton extends StatelessWidget {
  final double screenHeight, // height of the context screen
      screenWidth; // width of the context screen
  final String title;
  final IconData icon;
  final Function() function;
  final String tag;

  // Simple constructor for the log in form instance, which takes the context screen dimensions and the business logic object.
  const CustomFormButton(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.title,
      required this.icon,
      required this.function,
      required this.tag});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth < screenHeight ? screenWidth / 2 : screenWidth / 4,
      height: screenHeight / 10,
      child: FittedBox(
        child: FloatingActionButton.extended(
          heroTag: tag,
          onPressed: function,
          backgroundColor: Helper.yellowColor,
          icon: Icon(
            icon,
            color: Helper.blueColor,
          ),
          label: Text(
            title,
            style: const TextStyle(color: Helper.blueColor, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
