import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:lift_to_live_flutter/data/datasources/backend_api.dart';
import 'package:lift_to_live_flutter/domain/entities/workout.dart';
import 'package:lift_to_live_flutter/domain/entities/workout_set.dart';

import '../../domain/repositories/workout_repo.dart';
import '../exceptions/fetch_failed_exception.dart';

/// Implementation of a Workout repository (implementing the WorkoutRepository abstract class)
class WorkoutRepoImpl implements WorkoutRepository {
  // Instance of the backendAPI datasource object.
  final BackendAPI backendAPI;

  //Simple constructor for passing the datasource to the repository.
  WorkoutRepoImpl(this.backendAPI);

  /// This function is used for fetching all workout entries for a user.
  @override
  Future<List<Workout>> fetchWorkouts(String userId, String jwtToken) async {
    //fetch json response object
    Response response = await backendAPI.fetchWorkouts(userId, jwtToken);

    //proceed if fetch is successful and status code is 200
    if (response.statusCode == 200) {
      log("fetch workouts success!");

      //decode Workout objects
      List<Workout> myWorkouts = [];
      List<dynamic> list = json.decode(response.body);
      if(list.isEmpty) {
        throw FailedFetchException(
            "No workouts found!\nresponse code ${response.statusCode}");
      }

      for (var element in list) {
        myWorkouts.add(Workout.fromJson(element));
      }

      //return the Workout
      return myWorkouts;
    }

    //else throw an exception
    else {
      log("fetch workouts failed\nresponse code ${response.statusCode}");
      throw FailedFetchException(
          "Failed to fetch Workouts!\nresponse code ${response.statusCode}");
    }
  }

  /// This function is used for fetching a single template entry.
  @override
  Future<Workout> fetchTemplate(int id, String jwtToken) async {

    // return empty workout if a new one is requested
    if(id == 0) {
      return Workout(0, '', '', '', '', true, '', '', '', []);
    }

    //fetch json response object
    Response response = await backendAPI.fetchWorkout(id, jwtToken);

    //proceed if fetch is successful and status code is 200
    if (response.statusCode == 200) {
      log("fetch workouts success!");

      //decode Workout objects
      Workout myWorkout = Workout.fromJson(json.decode(response.body));

      //return the Workout
      return myWorkout;
    }

    //else throw an exception
    else {
      log("fetch workouts failed\nresponse code ${response.statusCode}");
      throw FailedFetchException(
          "Failed to fetch Workouts!\nresponse code ${response.statusCode}");
    }
  }

  /// This function is used for fetching a single workout entry.
  @override
  Future<Workout> fetchWorkout(int id, String jwtToken) async {
    //fetch json response object
    Response response = await backendAPI.fetchWorkout(id, jwtToken);

    //proceed if fetch is successful and status code is 200
    if (response.statusCode == 200) {
      log("fetch workouts success!");

      //decode Workout objects
      Workout myWorkout = Workout.fromJson(json.decode(response.body));

      //return the Workout
      return myWorkout;
    }

    //else throw an exception
    else {
      log("fetch workouts failed\nresponse code ${response.statusCode}");
      throw FailedFetchException(
          "Failed to fetch Workouts!\nresponse code ${response.statusCode}");
    }
  }

  /// This function is used for fetching the habits template for a user.
  @override
  Future<List<Workout>> fetchTemplates(String userId, String jwtToken) async {
    //fetch json response object
    Response response = await backendAPI.fetchWorkoutTemplates(userId, jwtToken);

    //proceed if fetch is successful and status code is 200
    if (response.statusCode == 200) {
      log("fetch template workouts success!");

      //decode template Workout objects
      List<Workout> myTemplates = [];
      List<dynamic> list = json.decode(response.body);

      if(list.isEmpty) {
        throw FailedFetchException(
            "No workout templates found!\nresponse code ${response.statusCode}");
      }

      for (var element in list) {
        myTemplates.add(Workout.fromJson(element));
      }

      return myTemplates;
    }

    //else throw an exception
    else {
      log("fetch template habit failed\nresponse code ${response.statusCode}");
      throw FailedFetchException(
          "Failed to fetch Workout!\nresponse code ${response.statusCode}");
    }
  }

  /// This function is used to patch a workout instance.
  @override
  Future<void> patchWorkout(int id, String coachNote, String note, String userId, String coachId, List<WorkoutSet> workoutSets, String completedOn, String createdOn, String name, String duration, bool isTemplate, String jwtToken) async {
    try {
      await backendAPI.patchWorkout(id, coachNote, note, userId, coachId, workoutSets, completedOn, createdOn, name, duration, isTemplate, jwtToken);
    } catch (e) {
      log("patch workout failed");
      throw FailedFetchException(
          "Failed to patch workout!\nresponse code ${e.toString()}");
    }
  }

  /// This function is used for posting workout entries.
  @override
  Future<void> postWorkout(String coachNote, String note, String userId, String coachId, List<WorkoutSet> workoutSets, String completedOn, String createdOn, String name, String duration, bool isTemplate, String jwtToken) async {
    try {
      await backendAPI.postWorkout(coachNote, note, userId, coachId, workoutSets, completedOn, createdOn, name, duration, isTemplate, jwtToken);
    } catch (e) {
      log("post workout failed");
      throw FailedFetchException(
          "Failed to post Workout!\nresponse code ${e.toString()}");
    }
  }

  /// This function is used to delete a workout.
  @override
  Future<void> deleteWorkout(int id, String jwtToken) async {
    try {
      var res = await backendAPI.deleteWorkout(id, jwtToken);

      if (res.statusCode != 200 && res.statusCode != 204) {
        log("delete workout failed");
        throw FailedFetchException("Failed to delete workout!");
      }
    } catch (e) {
      log("delete workout failed");
      throw FailedFetchException("Failed to delete workout!\n$e");
    }
  }
}
