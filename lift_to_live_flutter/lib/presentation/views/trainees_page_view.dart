// coverage:ignore-start

import 'package:flutter/material.dart';
import '../ui/widgets/trainee_search_holder.dart';

/// API to the TraineesPage view widget.
/// Describes the methods of the trainees page view implementation.
abstract class TraineesPageView {
  /// Function to set and display the user details, user profile picture.
  void setUserData(List<TraineeSearchHolder> users);

  /// Function to set if data is currently being fetched and an loading indicator should be displayed.
  void setInProgress(bool inProgress);

  /// Function to set if data is fetched and should be displayed.
  void setFetched(bool inProgress);

  /// Function to show a toast message when no user data can be fetched.
  void notifyNoUserData() {}

  /// Function called when user wants to navigate from profile page to pictures page
  void registerPressed(BuildContext context);

  /// Function to navigate to the selected user profile page
  void navigateToProfilePage(String id);
}

// coverage:ignore-end