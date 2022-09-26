import 'package:first_solo_flutter_app/helper.dart';
import 'package:first_solo_flutter_app/pages/sign_in_route.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LiftToLive',
      theme: ThemeData(
        // Add the 5 lines from here...
        appBarTheme: const AppBarTheme(
          backgroundColor: Helper.blueColor,
          foregroundColor: Colors.white,
        ),
      ),
      home: const SignInPage(),
    );
  }
}