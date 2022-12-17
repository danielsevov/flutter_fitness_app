// coverage:ignore-start

import 'package:flutter/material.dart';

/// API to the HabitsPage view widget.
/// Describes the methods of the habits page view implementation.
abstract class HabitsPageView {
  /// Function to set and display the habit data.
  void setHabitData(List<Widget> list);

  /// Function to set if data is currently being fetched and an loading indicator should be displayed.
  void setInProgress(bool inProgress);

  /// Function to set if data is fetched and should be displayed.
  void setFetched(bool inProgress);

  /// Function to notify if no habits were found
  void notifyNoHabitsFound();
}

// coverage:ignore-end
