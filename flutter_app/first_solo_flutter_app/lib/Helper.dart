import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helper {
  //blue and red shades used for the logo
  static const blueColor = Color.fromRGBO(11, 137, 156, 1), redColor = Color.fromRGBO(171, 0, 82, 1);
  static final DateFormat formatter = DateFormat('dd/MM/yyyy');

  static String imageToBlob(File file) {
    final bytes = file.readAsBytesSync();
    String img64 = base64Encode(bytes);
    return img64;
  }

//function for making SnackBar toasts
  static void makeToast(BuildContext context, String string) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(string),
    ));
  }

  //push page with animation to navigator
  static void pushPageWithAnimation(BuildContext context, Widget page) {
    Navigator.push(
      context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return FadeTransition(
              //position: animation.drive(tween),
              opacity: animation,
              child: child,
            );
          },
        )
    );
  }

  //push page to navigator
  static void pushPage(BuildContext context, Widget page) {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
        )
    );
  }

  //push page to navigator
  static void pushPageWithCallback(BuildContext context, Widget page, Function callback) {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return FadeTransition(
              //position: animation.drive(tween),
              opacity: animation,
              child: child,
            );
          },
        )
    ).then((value) => callback());
  }

  static void replacePage(BuildContext context, Widget page) {
    Route route = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

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
}