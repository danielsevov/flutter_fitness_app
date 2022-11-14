import 'package:lift_to_live_flutter/data/datasources/backend_api.dart';
import 'package:lift_to_live_flutter/data/repositories/news_repo_impl.dart';
import 'package:lift_to_live_flutter/data/repositories/user_repo_impl.dart';

import '../domain/repositories/news_repo.dart';
import '../domain/repositories/user_repo.dart';
import '../presentation/presenters/home_presenter.dart';

/// Factory object for creating a HomePagePresenter object, by attaching the required repositories and datasources.
/// This factory is a singleton object.
class HomePageFactory {
  static final HomePageFactory _instance = HomePageFactory._internal();

  HomePageFactory._internal();

  factory HomePageFactory() {
    return _instance;
  }

  BackendAPI backendAPI = BackendAPI(); //datasource

  NewsRepository getNewsRepository() => NewsRepoImpl(backendAPI); //news repository

  UserRepository getUserRepository() => UserRepoImpl(backendAPI); // user repository

  // function to get a HomePagePresenter object.
  HomePagePresenter getHomePagePresenter() => HomePagePresenter(getNewsRepository(), getUserRepository());
}