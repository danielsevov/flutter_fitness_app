import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:lift_to_live_flutter/domain/entities/exercise.dart';

import '../../domain/repositories/exercise_repo.dart';

/// Implementation of a Exercise repository (implementing the ExerciseRepository abstract class)
class ExerciseRepoImpl implements ExerciseRepository {
  //Simple constructor.
  ExerciseRepoImpl();

  /// This function is used for fetching a list of all Exercise objects.
  @override
  Future<List<Exercise>> getExercises() async {
      //fetch json response object
      String  response = await rootBundle.loadString('assets/jsons/exercises.json');

      List<Exercise> exercises = [];
      List<dynamic> list = json.decode(response);
      for (var element in list) {
        var exercise = Exercise.fromJson(element);
        exercises.add(exercise);
      }

      return exercises;
    }
}
