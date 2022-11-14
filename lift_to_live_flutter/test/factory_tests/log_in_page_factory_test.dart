import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/repositories/token_repo.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:lift_to_live_flutter/factory/log_in_page_factory.dart';
import 'package:lift_to_live_flutter/presentation/presenters/log_in_page_presenter.dart';

void main() {
  test('LogInPageFactory.getUserRepository() test', () {
    var repo = LogInPageFactory().getUserRepository();

    expect(repo, isA<UserRepository>());
  });

  test('LogInPageFactory.getTokenRepository() test', () {
    var repo = LogInPageFactory().getTokenRepository();

    expect(repo, isA<TokenRepository>());
  });

  test('LogInPageFactory.getLogInPresenter() test', () {
    var presenter = LogInPageFactory().getLogInPresenter();

    expect(presenter, isA<LogInPagePresenter>());
  });
}
