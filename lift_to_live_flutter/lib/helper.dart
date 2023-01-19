import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Helper class, holding helper methods, which can be easily reused by multiple objects and widgets
class Helper {
  static const
      // color palette
      blueColor = Color.fromRGBO(20, 33, 61, 1), // blue shade used for the logo
      lightBlueColor =
          Color.fromRGBO(27, 44, 79, 1.0), // blue shade used for the logo
      redColor = Color.fromRGBO(157, 31, 88, 1), // red shade used for the logo
      yellowColor =
          Color.fromRGBO(252, 163, 17, 1), // yellow shade used for the logo,
      blackColor = Colors.black, // black shade used for the logo
      whiteColor = Colors.white, // black shade used for the logo
      hintGreyColor =
          Color.fromRGBO(229, 229, 229, 0.5), // blue grey used for the text hint

      // default color scheme
      defaultTextColor = whiteColor, // default color of the text
      textFieldHintColor = hintGreyColor, // color of the text field hint text
      textFieldTextColor = whiteColor, // color of the text field text
      textFieldBorderColor = whiteColor, // color of the text field border
      textFieldErrorColor = yellowColor, // color of the text field error
      textFieldIconColor = whiteColor, // color of the text field icon
      pageBackgroundColor = lightBlueColor, // color of the page border
      actionButtonColor = yellowColor, // color of the action button
      confirmButtonColor = Colors.green, // color of the confirm button
      cancelButtonColor = Colors.red, // color of the cancel button
      actionButtonTextColor = blueColor, // color of the action button text
      confirmButtonTextColor = whiteColor, // color of the confirm button text
      cancelButtonTextColor = whiteColor, // color of the cancel button text
      backgroundColor = whiteColor, // color of the page background
      bottomBarIconColor = yellowColor, // color of the bottom nav bar icons
      bottomBarTextColor = yellowColor, // color of the bottom nav bar text
      headerBarIconColor = whiteColor, // color of the header nav bar icons
      headerBarTextColor = whiteColor, // color of the header nav bar text
      iconBackgroundColor = yellowColor, // color of the header nav bar text
      paragraphBackgroundColor = blueColor, // color of the paragraph background
      paragraphTextColor = whiteColor, // color of the paragraph text
      paragraphIconColor = yellowColor, // color of the paragraph icon
      darkHeadlineColor = yellowColor, // color of the darker headline
      lightHeadlineColor = whiteColor, // color of the lighter headline
      dividerColor = yellowColor; // color of the page divider

  static final DateFormat formatter = DateFormat(
      'dd/MM/yyyy'); //date formatter used for setting a DateTime in the 'dd/MM/yyyy' format

  static const pageBackgroundImage = 'assets/images/bluewaves.png',
      logoImage =
          'assets/images/lift-to-live-high-resolution-logo-white-on-transparent-background.png';

  /// Function used to generate a Blob from a image file
  static String imageToBlob(File file) {
    final bytes = file.readAsBytesSync();
    String img64 = base64Encode(bytes);
    return img64;
  }

  /// Function for making SnackBar toasts
  static void makeToast(BuildContext context, String string) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(string),
    ));
  }

  /// Function to push page with animation to navigator.
  static void pushPageWithAnimation(BuildContext context, Widget page) {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // const begin = Offset(0.0, 1.0);
            // const end = Offset.zero;
            // const curve = Curves.ease;

            // var tween =
            //     Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return FadeTransition(
              //position: animation.drive(tween),
              opacity: animation,
              child: child,
            );
          },
        ));
  }

  /// Function to push page to navigator.
  static void pushPage(BuildContext context, Widget page) {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
        ));
  }

  /// Function to push page to navigator with a callback function attached.
  static void pushPageWithCallback(
      BuildContext context, Widget page, Function callback) {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // const begin = Offset(0.0, 1.0);
            // const end = Offset.zero;
            // const curve = Curves.ease;

            // var tween =
            //     Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return FadeTransition(
              //position: animation.drive(tween),
              opacity: animation,
              child: child,
            );
          },
        )).then((value) => callback());
  }

  /// Function to replace by the Navigator the current page with a new one.
  static void replacePage(BuildContext context, Widget page) {
    Route route = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // const begin = Offset(0.0, 1.0);
        // const end = Offset.zero;
        // const curve = Curves.ease;

        // var tween =
        //     Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return FadeTransition(
          //position: animation.drive(tween),
          opacity: animation,
          child: child,
        );
      },
    );
    //MaterialPageRoute(builder: (context) => page);
    Navigator.pushReplacement(context, route);
  }

  /// Function to check if a date is before the current date
  static bool isDateBeforeToday(String date) {
    return DateTime.fromMicrosecondsSinceEpoch(int.parse(date) * 1000).isBefore(
        DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day));
  }

  /// Function for transforming dynamic list of strings to list of integers
  static List<int> toIntList(List<dynamic> list) {
    return list.map((e) => int.parse(e)).toList();
  }

  /// Function for transforming list of integers to list of strings
  static List<String> toStringList(List<int> list) {
    return list.map((e) => e.toString()).toList();
  }
}
