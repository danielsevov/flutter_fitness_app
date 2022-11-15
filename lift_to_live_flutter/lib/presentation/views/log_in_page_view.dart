// coverage:ignore-start

import 'package:lift_to_live_flutter/presentation/views/log_in_form_view.dart';

/// API to the LogInPage view widget.
/// Describes the methods of the log in page view implementation.
abstract class LogInPageView {
  /// Function to set if data is currently being fetched and an loading indicator should be displayed.
  void setInProgress(bool inProgress);

  /// Function to allow access to the log in Form.
  LogInFormView getLogInForm();

  /// Function to trigger page change from log in page to home page, upon successful log in.
  void navigateToHome() {}

  /// Function to display a toast message, when user cannot be authenticated.
  void notifyWrongCredentials() {}
}

// coverage:ignore-end