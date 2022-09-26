import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'models/habit_task.dart';
import 'models/role.dart';

class APIServices{
  static const apiURL = "http://192.168.178.28:3000/"; //molensingel
  //static const apiURL = "http://145.93.148.199:3000/"; //fontys

  static String jwtToken = "", userId = "";
  static List<Role> myRoles = [];

  static void patchImage(int id, String userId, String date, String data, String type) async {
    var res = await http.patch(
      Uri.parse('${apiURL}images/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(<String, String>{
        'date': date,
        'data': data,
        'user_id': userId,
        'type': type,
      }),
    );

    print(res.body);
  }

  static Future<http.Response> getImages(String userId) async {
    return http.post(
      Uri.parse('${apiURL}images_for_user/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(<String, String>{
        'user_id': userId,
      }),
    );
  }


  static void deleteImage(int id) async {
    http.delete(
      Uri.parse('${apiURL}images/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
    );
  }

  static Future<void> postImage(String userId, String date, String data, String type) async {
    var res = await http.post(
      Uri.parse('${apiURL}images/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(<String, String>{
        'date': date,
        'data': data,
        'user_id': userId,
        'type': type,
      }),
    );

    print(res.body);
  }

//function for sending user credentials for log in, promising future
  static Future<http.Response> logIn(String email, String password) async {
    return http.post(
      Uri.parse('${apiURL}login'),
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
  static Future<http.Response> fetchUserRoles() async {
    return http.get(
      Uri.parse('${apiURL}my_role'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
    );
  }

  static Future<http.Response> fetchUsers() async {
    return http.get(
      Uri.parse('${apiURL}users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
    );
  }

  //function to patch a habit instance
  static void patchHabit(int id, String date, String note, String userId,
      String coachId, List<HabitTask> habits) async {
    String inner = jsonEncode(habits);

    await http.patch(
      Uri.parse('${apiURL}habits/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
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
  static Future<http.Response> fetchTemplate(String userId, Function(http.Response res) callback) async {
    http.Response res = await http.post(
      Uri.parse('${apiURL}user_template_habit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(<String, String>{
        'userId': userId,
      }),
    );
    callback(res);
    return res;
  }

  static Future<http.Response> fetchHabits(String userId, Function(http.Response res) callback) async {
    fetchTemplate(userId, callback);
    return http.get(
      Uri.parse('${apiURL}habits'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
    );
  }

  static Future<http.Response> fetchUser(String userId, Function(http.Response res) callback) async {
    http.Response res = await http.post(
      Uri.parse('${apiURL}get_user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(<String, String>{
        'id': userId,
      }),
    );

    callback(res);
    return res;
  }

  static Future<http.Response> fetchProfileImage(String userId, Function(http.Response res) callback) async {
    http.Response res = await http.post(
      Uri.parse('${apiURL}profile_images_for_user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(<String, String>{
        'user_id': userId,
      }),
    );

    callback(res);
    return res;
  }

  //function for posting habits
  static Future<http.Response> postHabit(
      BuildContext context,
      String date,
      String note,
      String userId,
      String coachId,
      bool isTemplate,
      List<HabitTask> habits,
      Function(http.Response res) callback) async {
    String inner = jsonEncode(habits);

    http.Response res = await http.post(
      Uri.parse('${apiURL}habits'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: "${jsonEncode(<String, dynamic>{
        'date': date,
        'note': note,
        'userId': userId,
        'coachId': coachId,
        'is_template': isTemplate,
      }).replaceAll("}", "")}, \"habits\" : $inner}",
    );

    callback(res);
    return res;
  }

  static Future<void> initializeUserRoles() async {
    //fetch user roles
    var res = await fetchUserRoles();
    List<dynamic> list = json.decode(res.body);
    for (var element in list) {
      myRoles.add(Role.fromJson(element));
    }
  }

  static Future<http.Response> fetchNews(String search, int pageSize, Function(http.Response res) callback) async {
    var res = await http.get(
      Uri.parse('https://newsapi.org/v2/everything?q=$search&language=en&sortBy=publishedAt&pageSize=$pageSize&apiKey=21b8ce1c0a3c495bb2b09d76a16b8d61'),
    );

    callback(res);

    return res;
  }
}