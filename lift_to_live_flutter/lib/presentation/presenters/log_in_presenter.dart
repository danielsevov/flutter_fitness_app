import 'package:flutter/cupertino.dart';
import 'package:lift_to_live_flutter/domain/repositories/token_repo.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';

import '../state_management/app_state.dart';
import '../../helper.dart';
import '../views/log_in_view.dart';

class LogInPresenter {
  LogInView? _view;
  final TokenRepository _tokenRepository;
  final UserRepository _userRepository;
  late AppState _appState;
  bool _isInitialized = false;

  LogInPresenter(this._tokenRepository, this._userRepository);

  void attach(LogInView view) {
    _view = view;
  }

  void detach() {
    _view = null;
  }

  void setAppState(AppState appState) {
    _appState = appState;
    _isInitialized = true;
  }

  Future<void> logIn(BuildContext context) async {
    _view?.setInProgress(true);

    String? email = _view?.getEmail(), pass = _view?.getPassword();

    if(verifyCredentials(email, pass, context)) {
      String token = '';
      try {
         token = await _tokenRepository.getToken(email!, pass!);

         if(token.isNotEmpty) {

           var roles = await _userRepository.fetchUserRoles(token);
           _appState.setState(email, token, roles);

           _view?.navigateToHome();
         }
         else {
           _view?.clearPassword();
           _view?.notifyWrongCredentials();
         }

      }
      catch(e) {
        _view?.clearPassword();
        _view?.notifyWrongCredentials();
      }
    }

    _view?.setInProgress(false);
  }

  bool verifyCredentials(String? email, String? password, BuildContext context) {
    if(email == null || password == null) return false;

    //check email format
    if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
       Helper.makeToast(
           context, "Email must be in the right format (xxx@xxx.xxx)!");
       _view?.clearForm();
      return false;
    }

    //verify password
    else if (password.length < 8) {
      Helper.makeToast(context, "Password must be at least 8 characters long!");
      _view?.clearPassword();
      return false;
    }

    //verified successfully
    return true;
  }

  bool isInitialized() { return _isInitialized;}
}