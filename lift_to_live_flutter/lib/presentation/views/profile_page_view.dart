// coverage:ignore-start

import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';

/// API to the ProfilePage view widget.
/// Describes the methods of the home page view implementation.
abstract class ProfilePageView {
  /// Function to set and display the user details, user profile picture.
  void setUserData(User user, Image profilePicture);

  /// Function to set if data is currently being fetched and an loading indicator should be displayed.
  void setInProgress(bool inProgress);

  /// Function to show a toast message when no user data can be fetched.
  void notifyNoUserData() {}

  /// Function called when user wants to navigate from the users profile to the users habit page
  void habitsPressed(BuildContext context);

  /// Function called when user wants to navigate from profile page to pictures page
  void picturesPressed(BuildContext context);

  /// Function called when user wants to change the profile picture
  void changeProfilePicture(Image image);
}

// coverage:ignore-end