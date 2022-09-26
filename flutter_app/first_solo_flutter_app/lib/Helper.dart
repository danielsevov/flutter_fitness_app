import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/habit.dart';
import 'models/habit_task.dart';

class Helper {
  //blue and red shades used for the logo
  static const blueColor = Color.fromRGBO(11, 137, 156, 1), redColor = Color.fromRGBO(171, 0, 82, 1);


//function for sending user credentials for log in, promising future
  static Future<http.Response> logIn(String email, String password) async {
    return http.post(
      Uri.parse('http://192.168.178.28:3000/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
  }

//function for fetching user roles, promising future
  static Future<http.Response> fetchUserRoles(String token) async {
    return http.get(
      Uri.parse('http://192.168.178.28:3000/my_role'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
  }

  //function to patch a habit instance
  static void patchHabit(String token, int id, String date, String note, String userId,
      String coachId, List<HabitTask> habits) async {
    String inner = jsonEncode(habits);

    await http.patch(
      Uri.parse('http://192.168.178.28:3000/habits/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: "${jsonEncode(<String, String>{
        'date': date,
        'note': note,
        'userId': userId,
        'coachId': coachId,
      }).replaceAll("}", "")}, \"habits\" : $inner}",
    );
  }

  //function for fetching habits template
  static Future<http.Response> fetchTemplate(String token, String userId, Function(http.Response res) callback) async {
    http.Response res = await http.post(
      Uri.parse('http://192.168.178.28:3000/user_template_habit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'userId': userId,
      }),
    );
    callback(res);
    return res;
  }

  static Future<http.Response> fetchHabits(String token, String userId, Function(http.Response res) callback) async {
    fetchTemplate(token, userId, callback);
    return http.get(
      Uri.parse('http://192.168.178.28:3000/habits'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
  }

  //function for posting habits
  static Future<http.Response> postHabit(
      BuildContext context,
      List<Habit> allHabits,
      String token,
      String date,
      String note,
      String userId,
      String coachId,
      List<HabitTask> habits,
      Function(http.Response res) callback) async {
    String inner = jsonEncode(habits);

    http.Response res = await http.post(
      Uri.parse('http://192.168.178.28:3000/habits'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: "${jsonEncode(<String, String>{
        'date': date,
        'note': note,
        'userId': userId,
        'coachId': coachId,
      }).replaceAll("}", "")}, \"habits\" : $inner}",
    );

    callback(res);
    return res;
  }

//function for making SnackBar toasts
  static void makeToast(BuildContext context, String string) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(string),
    ));
  }

  //push page to navigator
  static void pushPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => page),
    );
  }

  static void replacePage(BuildContext context, Widget page) {
    Route route =
    MaterialPageRoute(builder: (context) => page);
    Navigator.pushReplacement(context, route);
  }
}