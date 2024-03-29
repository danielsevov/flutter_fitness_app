import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lift_to_live_flutter/domain/repositories/token_repo.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:lift_to_live_flutter/presentation/presenters/base_presenter.dart';
import '../views/log_in_page_view.dart';

/// This is the object, which holds the business logic, related to the Log In Page view.
/// It is the mediator between the LogIn view (UI) and the repositories (Data).
class LogInPagePresenter extends BasePresenter {
  LogInPageView? _view; // the log in view UI component
  late final TokenRepository
      _tokenRepository; // the repository used for fetching the JWT token
  late final UserRepository
      _userRepository; // the repository used for fetching the user roles

  /// Simple constructor
  LogInPagePresenter();

  /// Function to attach repositories
  void attachRepositories(TokenRepository tokenRepository, UserRepository userRepository) {
    _tokenRepository = tokenRepository;
    _userRepository = userRepository;
    super.repositoriesAttached = true;
  }

  /// Function to attach a view to the presenter
  void attach(LogInPageView view) {
    _view = view;
  }

  /// Function to detach the view from the presenter
  void detach() {
    _view = null;
  }

  // coverage:ignore-start
  /// Function, which is called upon user credentials submission and handles the authentication of the user.
  Future<void> logIn(FlutterSecureStorage secureStorage) async {
    // set the loading indicator to be shown on the page view
    _view?.setInProgress(true);

    String? email, pass;

    email = await secureStorage.read(key: 'username');
    pass = await secureStorage.read(key: 'password');

    if(email == null || pass == null) {
      // extract the email and password entries from the log in form
      email = _view?.getLogInForm().getEmail();
      pass = _view?.getLogInForm().getPassword();
    }

    // try to fetch a token based on the provided credentials
    String token = '';
    try {
      token = await _tokenRepository.getToken(email!, pass!);

      // if token is valid continue fetching user roles
      if (token.isNotEmpty) {
        var roles = await _userRepository.fetchUserRoles(token);

        // set the user roles in the app state object
        super.appState.setInitialState(email, token, roles);

        // store credentials
        await secureStorage.write(key: 'username', value: email);
        await secureStorage.write(key: 'password', value: pass);

        // navigate from log in to home page view
        _view?.navigateToHome();
      }

      // if token is not valid clear the log in form and notify the user
      else {
        _view?.getLogInForm().clearPassword();
        _view?.notifyWrongCredentials();
      }
    } catch (e) {
      _view?.getLogInForm().clearPassword();
      _view?.notifyWrongCredentials();
    }

    // stop the loading indicator as data processing is finished
    _view?.setInProgress(false);
  }
// coverage:ignore-end
}
