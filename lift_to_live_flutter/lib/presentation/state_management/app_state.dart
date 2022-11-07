import '../../domain/entities/role.dart';

class AppState {
  String _token = '', _userId = '';
  List<Role> _userRoles = [];

  void clearState() {
    _token = '';
    _userId = '';
    _userRoles.clear();
  }

  bool hasState() {
    return _token.isNotEmpty && _userId.isNotEmpty;
  }

  String getToken() {
    return _token;
  }

  String getUserId() {
    return _userId;
  }

  List<Role> getUserRoles() {
    return _userRoles;
  }

  void setState(String email, String token, List<Role> roles) {
    _userId = email;
    _token = token;
    _userRoles = roles;
  }

  bool isCoachOrAdmin() {
    return _userRoles.map((e) => e.name).contains("admin") || _userRoles.map((e) => e.name).contains("coach");
  }

  bool isAdmin() {
    return _userRoles.map((e) => e.name).contains("admin");
  }

  bool isCoach() {
    return _userRoles.map((e) => e.name).contains("coach");
  }

}