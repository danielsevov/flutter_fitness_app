import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:lift_to_live_flutter/factory/profile_page_factory.dart';
import 'package:lift_to_live_flutter/presentation/presenters/profile_page_presenter.dart';

void main() {
  test('ProfilePageFactory.getUserRepository() test', () {
    var repo = ProfilePageFactory().getUserRepository();

    expect(repo, isA<UserRepository>());
  });

  test('ProfilePageFactory.getHomePresenter() test', () {
    var presenter = ProfilePageFactory().getProfilePagePresenter('email@email.com');

    expect(presenter, isA<ProfilePagePresenter>());
  });
}
