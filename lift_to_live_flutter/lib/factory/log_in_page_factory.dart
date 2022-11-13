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

  TokenRepository getTokenRepository() => TokenRepoImpl();
  UserRepository getUserRepository() => UserRepoImpl();

  LogInPresenter getTokenPresenter() => LogInPresenter(getTokenRepository(), getUserRepository());
}