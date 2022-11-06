import 'package:flutter/cupertino.dart';
import 'package:lift_to_live_flutter/domain/repositories/token_repo.dart';

import '../../domain/app_state/app_state.dart';
import '../../helper.dart';
import '../views/token_view.dart';

class TokenPresenter {
  TokenView? _view;
  final TokenRepository _repository;
  late AppState _appState;
  bool _isInitialized = false;

  TokenPresenter(this._repository);

  void attach(TokenView view) {
    _view = view;
  }

  void detach() {
    _view = null;
  }

  void setAppState(AppState appState) {
    _appState = appState;
    _isInitialized = true;
  }

  Future<void> loadToken(BuildContext context) async {
    _view?.setInProgress(true);

    String? email = _view?.getEmail(), pass = _view?.getPassword();

    if(verifyCredentials(email, pass, context)) {
      String token = await _repository.getToken(email!, pass!);

      if(token.isNotEmpty) {
        _appState.setState(email, token);

        _view?.navigateToHome();
        //TODO navigate to home page
      }
      else {
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