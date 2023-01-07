// coverage:ignore-start

import 'package:flutter/material.dart';

/// API to the EditHabitsPage view widget.
/// Describes the methods of the edit habits page view implementation.
abstract class EditHabitsPageView {
  /// Function to set and display the habit data.
  void addTaskElement(String name, Function() callback);

  /// Function to set if data is currently being fetched and an loading indicator should be displayed.
  void setInProgress(bool inProgress);

  /// Function to set if data is fetched and should be displayed.
  void setFetched(bool inProgress);

  /// Clear controllers
  void clear();

  /// Refresh page
  refresh();

  /// Get text editing controllers to save changes
  List<TextEditingController> getControllers();

  ///Notify user when changes are saved
  void notifySavedChanges();

  /// Get and Set the current note
  String? getNote();
  void setNote(String note);
}

// coverage:ignore-end
