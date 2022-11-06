abstract class LogInView {

  void setInProgress(bool inProgress);

  String getPassword();

  String getEmail();

  void clearForm() {}

  void clearPassword() {}

  void navigateToHome() {}

  void notifyWrongCredentials() {}

}