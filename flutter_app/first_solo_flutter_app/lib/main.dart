import 'package:first_solo_flutter_app/Helper.dart';
import 'package:flutter/material.dart';
import 'package:first_solo_flutter_app/pages/login_route.dart';

import 'models/role.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static String jwtToken = "", userId = "";
  static List<Role> myRoles = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LiftToLive',
      theme: ThemeData(
        // Add the 5 lines from here...
        appBarTheme: const AppBarTheme(
          backgroundColor: Helper.blueColor,
          foregroundColor: Colors.black,
        ),
      ),
      home: const LogInRoute(),
    );
  }
}