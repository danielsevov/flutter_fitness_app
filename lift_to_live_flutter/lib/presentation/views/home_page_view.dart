// coverage:ignore-start

import 'package:flutter/material.dart';

import '../../domain/entities/news.dart';
import '../../domain/entities/user.dart';

/// API to the HomePage view widget.
/// Describes the methods of the home page view implementation.
abstract class HomePageView {
  get screenWidth;

  get screenHeight;

  get isFetched;

  get userData;

  get profilePicture;

  get currentNews;

  /// Function to set and display the user details, user profile picture.
  void setUserData(User user, Image profilePicture);

  /// Function to set and display the list of news.
  void setNewsData(News currentNews);

  /// Function to set if data is currently being fetched and an loading indicator should be displayed.
  void setInProgress(bool inProgress);

  /// Function to indicate that the required data has been fetched, so appropriate layout can be displayed.
  void setFetched(bool fetched);

  /// Function to show a toast message when a news URL is incorrect.
  void notifyWrongURL(String s);

  /// Function called when user wants to navigate from home to habit page
  void habitsPressed(bool bottomBarButton);

  /// Function called when user wants to navigate from home to profile page
  void profilePressed(bool bottomBarButton);

  /// Function called when user wants to log out
  void logOutPressed(BuildContext context);

  /// Function for showing sign out dialog
  void showSignOutDialog();

  /// Function called when user wants to navigate from home to trainees page
  /// This is only allowed if user is admin or coach.
  void traineesPressed(bool bottomBarButton);

  /// Function to call when button pressed to redirect user to URL
  void redirectToUrl(int index);

  /// Function called when user wants to navigate from home to workout history page
  void historyPressed(bool fromBottomBar);

  /// Function for navigating to edit workout templates page.
  void templatesPressed(bool bool);

  /// Function for navigating to edit workout page.
  void workoutPressed(bool bool);
}

// coverage:ignore-end
