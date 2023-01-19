// coverage:ignore-file

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../domain/entities/habit_task.dart';
import '../../domain/entities/workout_set.dart';

/// This is a datasource object, which handles the communication with the Backend REST API.
/// The communication is done via http requests, using the http.dart package.
class BackendAPI {
  static final BackendAPI _singleton = BackendAPI._internal();

  factory BackendAPI() {
    return _singleton;
  }

  BackendAPI._internal();

  static const apiURL = "http://192.168.178.25:3000/"; //molensingel
  //static const apiURL = "http://145.93.150.0:3000/"; //fontys
  //static const apiURL = "http://lift2live.synology.me:3000/"; // sofia
  //static const apiURL = "http://192.168.13.9:3000/"; // sofia new

  /// This function is used for patching an image entry.
  Future<http.Response> patchImage(int id, String userId, String date,
      String data, String type, String token) async {
    var res = await http.patch(
      Uri.parse('${apiURL}images/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'date': date,
        'data': data,
        'user_id': userId,
        'type': type,
      }),
    );
    log(res.body);
    return res;
  }

  /// This function is used for fetching all image entries for a user.
  Future<http.Response> fetchImages(String userId, String jwtToken) async {
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

  /// This function is used for deleting an image entry.
  Future<http.Response> deleteImage(int id, String jwtToken) async {
    var res = await http.delete(
      Uri.parse('${apiURL}images/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
    );
    return res;
  }

  /// This function is used for fetching all workout entries for a user.
  Future<http.Response> fetchWorkouts(String userId, String jwtToken) async {
    return http.post(
      Uri.parse('${apiURL}workouts_for_user/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(<String, String>{
        'id': userId,
      }),
    );
  }

  /// This function is used for fetching single workout entry.
  Future<http.Response> fetchWorkout(int id, String jwtToken) async {
    return http.get(
      Uri.parse('${apiURL}workouts/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
    );
  }

  /// This function is used for fetching all workout templates entries for a user.
  Future<http.Response> fetchWorkoutTemplates(String userId, String jwtToken) async {
    return http.post(
      Uri.parse('${apiURL}workout_templates_for_user/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(<String, String>{
        'id': userId,
      }),
    );
  }

  /// This function is used for deleting an workout entry.
  Future<http.Response> deleteWorkout(int id, String jwtToken) async {
    var res = await http.delete(
      Uri.parse('${apiURL}workouts/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
    );
    return res;
  }

  /// This function is used for posting a new workout.
  Future<http.Response> postWorkout(String coachNote, String note, String userId,
      String coachId, List<WorkoutSet> sets, String completedOn, String createdOn, String name, String duration, bool isTemplate, String jwtToken) async {
    String inner = jsonEncode(sets);
    var res = await http.post(
      Uri.parse('${apiURL}workouts/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: "${jsonEncode(<String, dynamic>{
        'coach_note': coachNote,
        'workout_name': name,
        'completed_on': completedOn,
        'created_on': createdOn,
        'duration': duration,
        'userId': userId,
        'coachId': coachId,
        'is_template': isTemplate,
      }).replaceAll("}", "")}, \"sets\" : $inner}",
    );
    log(res.body);
    return res;
  }

  /// This function is used for updating a new workout.
  Future<http.Response> patchWorkout(int id, String coachNote, String note, String userId,
      String coachId, List<WorkoutSet> sets, String completedOn, String createdOn, String name, String duration, bool isTemplate, String jwtToken) async {
    String inner = jsonEncode(sets);
    var res = await http.patch(
      Uri.parse('${apiURL}workouts/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: "${jsonEncode(<String, dynamic>{
        'coach_note': coachNote,
        'workout_name': name,
        'completed_on': completedOn,
        'created_on': createdOn,
        'duration': duration,
        'userId': userId,
        'coachId': coachId,
        'is_template': isTemplate,
      }).replaceAll("}", "")}, \"sets\" : $inner}",
    );
    log(res.body);
    return res;
  }

  /// This function is used for posting a new image.
  Future<http.Response> postImage(String userId, String date, String data,
      String type, String jwtToken) async {
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
    log(res.body);
    return res;
  }

  /// This function is used to patch a habit instance.
  Future<http.Response> patchHabit(
      int id,
      String date,
      String note,
      String userId,
      String coachId,
      List<HabitTask> habits,
      String jwtToken) async {
    String inner = jsonEncode(habits);

    var res = await http.patch(
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
    return res;
  }

  /// This function is used for fetching the habits template of a user.
  Future<http.Response> fetchHabitTemplate(String userId, String jwtToken) async {
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
    return res;
  }

  /// This function is used for fetching all habit entries for a user.
  Future<http.Response> fetchHabits(String userId, String jwtToken) async {
    fetchHabitTemplate(userId, jwtToken);
    return http.post(
      Uri.parse('${apiURL}user_habits'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(<String, String>{
        'userId': userId,
      }),
    );
  }

  /// function for posting habits
  Future<http.Response> postHabit(
      String date,
      String note,
      String userId,
      String coachId,
      bool isTemplate,
      List<HabitTask> habits,
      String jwtToken) async {
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
    return res;
  }

  /// This function is used for sending user credentials for log in and receiving a token upon authentication.
  Future<http.Response> logIn(String email, String password) async {
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

  /// This function is used to post the user data of a single user.
  Future<http.Response> registerUser(
      String userId,
      String coachId,
      String password,
      String name,
      String phoneNumber,
      String nationality,
      String dateOfBirth,
      String jwtToken) async {
    http.Response res = await http.post(
      Uri.parse('${apiURL}signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode(<String, String>{
        'id': userId,
        'email': userId,
        'password': password,
        'name': name,
        'phone_number': phoneNumber,
        'nationality': nationality,
        'date_of_birth': dateOfBirth,
        'coach_id': coachId,
      }),
    );
    return res;
  }

  /// This function is used for fetching the user roles of the authenticated current user.
  Future<http.Response> fetchUserRoles(String jwtToken) async {
    return http.get(
      Uri.parse('${apiURL}my_role'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
    );
  }

  /// This function is used for fetching all coach user roles.
  Future<http.Response> fetchCoachRoles(String jwtToken) async {
    return http.get(
      Uri.parse('${apiURL}coaches_roles'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
    );
  }

  /// This function is used for fetching all users in the database, if the current user is authorized to do so.
  Future<http.Response> fetchUsers(String jwtToken) async {
    return http.get(
      Uri.parse('${apiURL}users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
    );
  }

  /// This function is used for fetching all trainees of the current user in the database, if the current user is authorized to do so.
  Future<http.Response> fetchMyTrainees(String jwtToken) async {
    return http.get(
      Uri.parse('${apiURL}my_trainees'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
    );
  }

  /// This function is used to fetch the user data of a single user, if the current user is authorized to do so.
  Future<http.Response> fetchUser(String userId, String jwtToken) async {
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
    return res;
  }

  /// This function is used to fetch user images for a single user, if the current user is authorized to do so.
  Future<http.Response> fetchProfileImage(
      String userId, String jwtToken) async {
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
    return res;
  }
}
