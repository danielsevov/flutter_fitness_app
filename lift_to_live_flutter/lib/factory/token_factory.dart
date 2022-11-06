import '../data/repositories/token_repo_impl.dart';
import '../domain/repositories/token_repo.dart';
import '../presentation/presenters/log_in_presenter.dart';

class TokenFactory {
  static final TokenFactory _instance = TokenFactory._internal();

  TokenFactory._internal();

  factory TokenFactory() {
    return _instance;
  }

  TokenRepository getTokenRepository() => TokenRepoImpl();

  LogInPresenter getTokenPresenter() => LogInPresenter(getTokenRepository());
}