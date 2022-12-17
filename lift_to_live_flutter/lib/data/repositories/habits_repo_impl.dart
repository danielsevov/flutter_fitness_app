import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:lift_to_live_flutter/data/datasources/backend_api.dart';
import 'package:lift_to_live_flutter/domain/entities/habit.dart';
import 'package:lift_to_live_flutter/domain/entities/habit_task.dart';

import '../../domain/repositories/habits_repo.dart';
import '../exceptions/fetch_failed_exception.dart';

/// Implementation of a Habits repository (implementing the HabitsRepository abstract class)
class HabitsRepoImpl implements HabitsRepository {
  // Instance of the backendAPI datasource object.
  final BackendAPI backendAPI;

  //Simple constructor for passing the datasource to the repository.
  HabitsRepoImpl(this.backendAPI);

  /// This function is used for fetching all habit entries for a user.
  @override
  Future<List<Habit>> fetchHabits(String userId, String jwtToken) async {
    //fetch http response object
    Response response = await backendAPI.fetchHabits(userId, jwtToken);

    //proceed if fetch is successful and status code is 200
    if (response.statusCode == 200) {
      log("fetch habits!\nHabits:${response.body}");

      //decode Habits objects
      List<Habit> myHabits = [];
      List<dynamic> list = json.decode(response.body);
      for (var element in list) {
        myHabits.add(Habit.fromJson(element));
      }

      //return the Habits
      return myHabits;
    }

    //else throw an exception
    else {
      log("fetch habits failed\nresponse code ${response.statusCode}");
      throw FailedFetchException(
          "Failed to fetch Habits!\nresponse code ${response.statusCode}");
    }
  }

  /// This function is used for fetching the habits template for a user.
  @override
  Future<Habit> fetchTemplate(String userId, String jwtToken) async {
    //fetch http response object
    Response response = await backendAPI.fetchTemplate(userId, jwtToken);

    //proceed if fetch is successful and status code is 200
    if (response.statusCode == 200) {
      log("fetch template habits success!\nHabits:${response.body}");

      //decode template Habits object
      List<Habit> myHabits = [];
      List<dynamic> list = json.decode(response.body);
      for (var element in list) {
        myHabits.add(Habit.fromJson(element));
      }

      if (myHabits.isNotEmpty) {
        //return the Habits
        return myHabits[0];
      } else {
        return Habit(0, '', '', '', '', true, [HabitTask('My Task 1', false)]);
      }
    }

    //else throw an exception
    else {
      log("fetch template habit failed\nresponse code ${response.statusCode}");
      throw FailedFetchException(
          "Failed to fetch Habits!\nresponse code ${response.statusCode}");
    }
  }

  /// This function is used to patch a habit instance.
  @override
  Future<void> patchHabit(int id, String date, String note, String userId,
      String coachId, List<HabitTask> habits, String jwtToken) async {
    try {
      await backendAPI.patchHabit(
          id, date, note, userId, coachId, habits, jwtToken);
    } catch (e) {
      log("patch habit failed");
      throw FailedFetchException(
          "Failed to patch Habit!\nresponse code ${e.toString()}");
    }
  }

  /// This function is used for posting habit entries.
  @override
  Future<void> postHabit(
      String date,
      String note,
      String userId,
      String coachId,
      bool isTemplate,
      List<HabitTask> habits,
      String jwtToken) async {
    try {
      await backendAPI.postHabit(
          date, note, userId, coachId, isTemplate, habits, jwtToken);
    } catch (e) {
      log("post habit failed");
      throw FailedFetchException(
          "Failed to post Habit!\nresponse code ${e.toString()}");
    }
  }
}
