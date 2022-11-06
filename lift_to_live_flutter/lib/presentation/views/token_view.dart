abstract class TokenView {

  void setInProgress(bool inProgress);

  String getPassword();

  String getEmail();

  void clearForm() {}

  void clearPassword() {}

  void navigateToHome() {}

  void notifyWrongCredentials() {}

}