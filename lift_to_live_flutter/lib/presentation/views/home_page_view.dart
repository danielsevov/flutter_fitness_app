// coverage:ignore-file

import 'package:flutter/material.dart';

import '../../domain/entities/news.dart';
import '../../domain/entities/user.dart';

/// API to the HomePage view widget.
/// Describes the methods of the home page view implementation.
abstract class HomePageView {
  /// Function to set and display the user details, user profile picture.
  void setUserData(User user, Image profilePicture);

  /// Function to set and display the list of news.
  void setNewsData(News currentNews);

  /// Function to set if data is currently being fetched and an loading indicator should be displayed.
  void setInProgress(bool inProgress);

  /// Function to indicate that the required data has been fetched, so appropriate layout can be displayed.
  void setFetched(bool fetched) {}

  /// Function to show a toast message when a news URL is incorrect.
  void notifyWrongURL(String s) {}
}
