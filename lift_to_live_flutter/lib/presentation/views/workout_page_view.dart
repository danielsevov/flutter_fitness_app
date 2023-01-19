// coverage:ignore-start

import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/editable_set_holder.dart';

/// API to the WorkoutPage view widget.
/// Describes the methods of the workout templates page view implementation.
abstract class WorkoutPageView {
  get noteController;
  get nameController;

  /// Function to set and display the workout template data.
  void setTemplateData( String templateName, String templateNote, List<EditableSetHolder> workoutSetWidgets);

  /// Function to set if data is currently being fetched and an loading indicator should be displayed.
  void setInProgress(bool inProgress);

  /// Function to set if data is fetched and should be displayed.
  void setFetched(bool inProgress);

  /// Function to notify there is no name entered for the template
  void notifyNoName();

  /// Function to notify there is no set data entered for the template
  void notifyNoSets();

  /// Function to notify the template is saved
  void notifySaved();
}

// coverage:ignore-end
