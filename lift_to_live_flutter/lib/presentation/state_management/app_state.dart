import '../../domain/entities/role.dart';

/// AppState object is a holder of the data, which is shared among multiple pages and widgets.
/// It is used in combination with the Provider package to allow pages to look up the app state
/// object in the widget tree and to access it, when needed.
class AppState {
  String _token = '',         // JWT token for the current session
      _userId = '';           // user id of the current logged in user
  List<Role> _userRoles = []; // list of the user roles of the current logged in user

  /// Function used to restore the default app state.
  void clearState() {
    _token = '';
    _userId = '';
    _userRoles.clear();
  }

  /// Function to indicate if the app state is initialized, thus different from the default empty state.
  bool hasState() {
    return _token.isNotEmpty && _userId.isNotEmpty;
  }

  /// Getter for the token
  String getToken() {
    return _token;
  }

  /// Getter for the user ID
  String getUserId() {
    return _userId;
  }

  /// Getter for the list of user roles
  List<Role> getUserRoles() {
    return _userRoles;
  }

  /// Setter for the app state
  void setState(String email, String token, List<Role> roles) {
    _userId = email;
    _token = token;
    _userRoles = roles;
  }

  /// Function to indicate if the current logged in user is admin or coach.
  bool isCoachOrAdmin() {
    return _userRoles.map((e) => e.name).contains("admin") || _userRoles.map((e) => e.name).contains("coach");
  }

  /// Function to indicate if the current logged in user is admin.
  bool isAdmin() {
    return _userRoles.map((e) => e.name).contains("admin");
  }

  /// Function to indicate if the current logged in user is coach.
  bool isCoach() {
    return _userRoles.map((e) => e.name).contains("coach");
  }

}