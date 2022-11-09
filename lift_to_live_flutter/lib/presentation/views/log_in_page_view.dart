import 'package:lift_to_live_flutter/presentation/views/log_in_form_view.dart';

abstract class LogInPageView {

  void setInProgress(bool inProgress);

  LogInFormView getLogInForm();

  void navigateToHome() {}

  void notifyWrongCredentials() {}

}