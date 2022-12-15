import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/repositories/habits_repo.dart';
import 'package:lift_to_live_flutter/domain/repositories/news_repo.dart';
import 'package:lift_to_live_flutter/domain/repositories/token_repo.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:lift_to_live_flutter/factory/presenter_factory.dart';
import 'package:lift_to_live_flutter/presentation/presenters/edit_habits_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/presenters/habits_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/presenters/home_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/presenters/log_in_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/presenters/picture_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/presenters/profile_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/presenters/trainees_page_presenter.dart';

void main() {
  test('PresenterFactory.getUserRepository() test', () {
    var repo = PresenterFactory().getUserRepository();

    expect(repo, isA<UserRepository>());
  });

  test('PresenterFactory.getTokenRepository() test', () {
    var repo = PresenterFactory().getTokenRepository();

    expect(repo, isA<TokenRepository>());
  });

  test('PresenterFactory.getLogInPresenter() test', () {
    var presenter = PresenterFactory().getLogInPresenter();

    expect(presenter, isA<LogInPagePresenter>());
  });

  test('PresenterFactory.getNewsRepository() test', () {
    var repo = PresenterFactory().getNewsRepository();

    expect(repo, isA<NewsRepository>());
  });

  test('PresenterFactory.getHomePresenter() test', () {
    var presenter = PresenterFactory().getHomePagePresenter();

    expect(presenter, isA<HomePagePresenter>());
  });

  test('PresenterFactory.getHabitsRepository() test', () {
    var repo = PresenterFactory().getHabitsRepository();

    expect(repo, isA<HabitsRepository>());
  });

  test('PresenterFactory.getHabitsPagePresenter() test', () {
    var presenter = PresenterFactory().getHabitsPagePresenter('email@email.com');

    expect(presenter, isA<HabitsPagePresenter>());
  });

  test('PresenterFactory.getPicturePagePresenter() test', () {
    var presenter = PresenterFactory().getPicturePagePresenter('email@email.com');

    expect(presenter, isA<PicturePagePresenter>());
  });

  test('EditPresenterFactory.getEditHabitsPagePresenter() test', () {
    var presenter = PresenterFactory().getEditHabitsPagePresenter('email@email.com');

    expect(presenter, isA<EditHabitsPagePresenter>());
  });

  test('PresenterFactory.getHomePresenter() test', () {
    var presenter = PresenterFactory().getProfilePagePresenter('email@email.com');

    expect(presenter, isA<ProfilePagePresenter>());
  });

  test('PresenterFactory.getHomePresenter() test', () {
    var presenter = PresenterFactory().getTraineesPagePresenter();

    expect(presenter, isA<TraineesPagePresenter>());
  });
}
