import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/repositories/news_repo.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:lift_to_live_flutter/factory/home_page_factory.dart';
import 'package:lift_to_live_flutter/presentation/presenters/home_page_presenter.dart';

void main() {
  test('HomePageFactory.getUserRepository() test', () {
    var repo = HomePageFactory().getUserRepository();

    expect(repo, isA<UserRepository>());
  });

  test('HomePageFactory.getNewsRepository() test', () {
    var repo = HomePageFactory().getNewsRepository();

    expect(repo, isA<NewsRepository>());
  });

  test('HomePageFactory.getHomePresenter() test', () {
    var presenter = HomePageFactory().getHomePagePresenter();

    expect(presenter, isA<HomePagePresenter>());
  });

  test('HomePageFactory.getWrappedHomePage() test', () {
    var presenter = HomePageFactory().getWrappedHomePage();

    expect(presenter, isA<DefaultBottomBarController>());
  });
}
