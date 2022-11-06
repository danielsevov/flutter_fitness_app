class AppState {
  String _token = '', _userId = '';

  void clearState() {
    _token = '';
    _userId = '';
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

  void setState(String email, String token) {
    _userId = email;
    _token = token;
  }

}