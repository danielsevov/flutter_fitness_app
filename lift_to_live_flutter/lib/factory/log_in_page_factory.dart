import 'package:lift_to_live_flutter/data/datasources/backend_api.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';

import '../data/repositories/token_repo_impl.dart';
import '../data/repositories/user_repo_impl.dart';
import '../domain/repositories/token_repo.dart';
import '../presentation/presenters/log_in_presenter.dart';

class LogInPageFactory {
  static final LogInPageFactory _instance = LogInPageFactory._internal();

  LogInPageFactory._internal();

  factory LogInPageFactory() {
    return _instance;
  }

  BackendAPI backendAPI = BackendAPI();

  TokenRepository getTokenRepository() => TokenRepoImpl(backendAPI);
  UserRepository getUserRepository() => UserRepoImpl(backendAPI);

  LogInPagePresenter getLogInPresenter() => LogInPagePresenter(getTokenRepository(), getUserRepository());
}