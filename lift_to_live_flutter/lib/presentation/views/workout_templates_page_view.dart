// coverage:ignore-start

import 'package:flutter/material.dart';

/// API to the WorkoutTemplatesPage view widget.
/// Describes the methods of the workout templates page view implementation.
abstract class WorkoutTemplatesPageView {
  /// Function to set and display the workout template data.
  void setWorkoutData(List<Widget> list);

  /// Function to set if data is currently being fetched and an loading indicator should be displayed.
  void setInProgress(bool inProgress);

  /// Function to set if data is fetched and should be displayed.
  void setFetched(bool inProgress);

  /// Function to notify if no template workouts were found
  void notifyNoTemplateWorkoutsFound();

  /// Function to notify a template has been copied
  void notifyNewTemplate() {}
}

// coverage:ignore-end
