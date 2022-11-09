import 'package:flutter/cupertino.dart';
import 'package:lift_to_live_flutter/domain/repositories/token_repo.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';

import '../state_management/app_state.dart';
import '../views/log_in_page_view.dart';

class LogInPresenter {
  LogInPageView? _view;
  final TokenRepository _tokenRepository;
  final UserRepository _userRepository;
  late AppState _appState;
  bool _isInitialized = false;

  LogInPresenter(this._tokenRepository, this._userRepository);

  void attach(LogInPageView view) {
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

    String? email = _view?.getLogInForm().getEmail(),
        pass = _view?.getLogInForm().getPassword();

    String token = '';
    try {
      token = await _tokenRepository.getToken(email!, pass!);

      if (token.isNotEmpty) {
        var roles = await _userRepository.fetchUserRoles(token);
        _appState.setState(email, token, roles);

        _view?.navigateToHome();
      } else {
        _view?.getLogInForm().clearPassword();
        _view?.notifyWrongCredentials();
      }
    } catch (e) {
      _view?.getLogInForm().clearPassword();
      _view?.notifyWrongCredentials();
    }

    _view?.setInProgress(false);
  }

  bool isInitialized() {
    return _isInitialized;
  }
}
