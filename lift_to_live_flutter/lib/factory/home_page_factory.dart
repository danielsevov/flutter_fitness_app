import 'package:lift_to_live_flutter/data/datasources/backend_api.dart';
import 'package:lift_to_live_flutter/data/repositories/news_repo_impl.dart';
import 'package:lift_to_live_flutter/data/repositories/user_repo_impl.dart';

import '../domain/repositories/news_repo.dart';
import '../domain/repositories/user_repo.dart';
import '../presentation/presenters/home_presenter.dart';

class HomePageFactory {
  static final HomePageFactory _instance = HomePageFactory._internal();

  HomePageFactory._internal();

  factory HomePageFactory() {
    return _instance;
  }

  BackendAPI backendAPI = BackendAPI();

  NewsRepository getNewsRepository() => NewsRepoImpl(backendAPI);

  UserRepository getUserRepository() => UserRepoImpl(backendAPI);

  HomePagePresenter getHomePresenter() => HomePagePresenter(getNewsRepository(), getUserRepository());
}