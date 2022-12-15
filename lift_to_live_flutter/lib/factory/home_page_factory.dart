import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:lift_to_live_flutter/data/datasources/backend_api.dart';
import 'package:lift_to_live_flutter/data/datasources/news_api.dart';
import 'package:lift_to_live_flutter/data/repositories/news_repo_impl.dart';
import 'package:lift_to_live_flutter/data/repositories/user_repo_impl.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/home_page.dart';

import '../domain/repositories/news_repo.dart';
import '../domain/repositories/user_repo.dart';
import '../presentation/presenters/home_page_presenter.dart';

/// Factory object for creating a HomePagePresenter object, by attaching the required repositories and datasources.
/// This factory is a singleton object.
class HomePageFactory {
  static final HomePageFactory _instance = HomePageFactory._internal();

  HomePageFactory._internal();

  factory HomePageFactory() {
    return _instance;
  }

  BackendAPI backendAPI = BackendAPI(); //datasource
  NewsAPI newsAPI = NewsAPI(); //datasource

  NewsRepository getNewsRepository() =>
      NewsRepoImpl(newsAPI); //news repository

  UserRepository getUserRepository() =>
      UserRepoImpl(backendAPI); // user repository

  // function to get a HomePagePresenter object.
  HomePagePresenter getHomePagePresenter() =>
      HomePagePresenter(getNewsRepository(), getUserRepository());

  // function to get a HomePagePresenter object wrapped in a BottomBarController so that the expandable bottom nav bar can be used.
  DefaultBottomBarController getWrappedHomePage() => DefaultBottomBarController(child:const HomePage());
}
