import 'package:lift_to_live_flutter/data/repositories/news_repo_impl.dart';
import 'package:lift_to_live_flutter/data/repositories/user_repo_impl.dart';

import '../domain/repositories/news_repo.dart';
import '../domain/repositories/user_repo.dart';
import '../presentation/presenters/home_presenter.dart';

class HomeFactory {
  static final HomeFactory _instance = HomeFactory._internal();

  HomeFactory._internal();

  factory HomeFactory() {
    return _instance;
  }

  NewsRepository getNewsRepository() => NewsRepoImpl();

  UserRepository getUserRepository() => UserRepoImpl();

  HomePresenter getHomePresenter() => HomePresenter(getNewsRepository(), getUserRepository());
}