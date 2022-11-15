// coverage:ignore-start

/// API to the LogInForm view widget.
/// Describes the methods of the log in form view implementation.
abstract class LogInFormView {
  /// Function to get the current password entry.
  String getPassword();

  /// Function to get the current email entry.
  String getEmail();

  /// Function to clear the current email and password entries.
  void clearForm() {}

  /// Function to clear the current password entry.
  void clearPassword() {}
}

// coverage:ignore-end