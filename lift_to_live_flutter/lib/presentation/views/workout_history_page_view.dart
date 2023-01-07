// coverage:ignore-start

import 'package:flutter/material.dart';

/// API to the WorkoutHistoryPage view widget.
/// Describes the methods of the workout history page view implementation.
abstract class WorkoutHistoryPageView {
  /// Function to set and display the workout data.
  void setWorkoutData(List<Widget> list, List<String> workoutDates);

  /// Function to set if data is currently being fetched and an loading indicator should be displayed.
  void setInProgress(bool inProgress);

  /// Function to set if data is fetched and should be displayed.
  void setFetched(bool inProgress);

  /// Function to notify if no workouts were found
  void notifyNoWorkoutsFound();
}

// coverage:ignore-end
