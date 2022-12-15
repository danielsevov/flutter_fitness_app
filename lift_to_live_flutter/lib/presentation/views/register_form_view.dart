// coverage:ignore-start

/// API to the RegisterForm view widget.
/// Describes the methods of the register form view implementation.
abstract class RegisterFormView {
  /// Function to get the current password entry.
  String getPassword();

  /// Function to get the current email entry.
  String getEmail();

  /// Function to get the current name entry.
  String getName();

  /// Function to get the current phone number entry.
  String getPhoneNumber();

  /// Function to get the current nationality entry.
  String getNationality();

  /// Function to get the current coach email entry.
  String getCoachEmail();

  /// Function to get the current birthday entry.
  String getDateOfBirth();

  /// Function to clear the current entries.
  void clearForm() {}

  /// Function to clear the current password entry.
  void clearPassword() {}

  /// Function to clear the current email entry.
  void clearEmail() {}
}

// coverage:ignore-end