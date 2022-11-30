import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:lift_to_live_flutter/factory/trainees_page_factory.dart';
import 'package:lift_to_live_flutter/presentation/presenters/trainees_page_presenter.dart';

void main() {
  test('TraineesPageFactory.getUserRepository() test', () {
    var repo = TraineesPageFactory().getUserRepository();

    expect(repo, isA<UserRepository>());
  });

  test('TraineesPageFactory.getHomePresenter() test', () {
    var presenter = TraineesPageFactory().getTraineesPagePresenter();

    expect(presenter, isA<TraineesPagePresenter>());
  });
}
