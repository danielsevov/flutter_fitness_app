// coverage:ignore-start

import 'package:lift_to_live_flutter/presentation/views/register_form_view.dart';

/// API to the RegisterPage view widget.
/// Describes the methods of the register page view implementation.
abstract class RegisterPageView {
  /// Function to set if data is currently being fetched and an loading indicator should be displayed.
  void setInProgress(bool inProgress);

  /// Function to allow access to the register Form.
  RegisterFormView getRegisterForm();

  /// Function to display a toast message, when user cannot be registered due to duplicated email.
  void notifyEmailAlreadyExists();

  /// Function to notify the user that he has successfully registered a new user.
  void notifyUserRegistered();

  /// Function to notify the user that registering a new user failed due to unexpected exception.
  void notifyRegisterFailed();

  /// Function to notify the page that the required data has been fetched
  void setFetched(bool bool);

  /// Function to pass the required coach data to the page view
  void setCoachData(List<String> coachesIds);
}

// coverage:ignore-end
