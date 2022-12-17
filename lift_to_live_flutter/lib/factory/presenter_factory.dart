import 'package:lift_to_live_flutter/data/datasources/backend_api.dart';
import 'package:lift_to_live_flutter/domain/repositories/habits_repo.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';

import '../data/datasources/news_api.dart';
import '../data/repositories/habits_repo_impl.dart';
import '../data/repositories/news_repo_impl.dart';
import '../data/repositories/token_repo_impl.dart';
import '../data/repositories/user_repo_impl.dart';
import '../domain/repositories/news_repo.dart';
import '../domain/repositories/token_repo.dart';
import '../presentation/presenters/edit_habits_page_presenter.dart';
import '../presentation/presenters/habits_page_presenter.dart';
import '../presentation/presenters/home_page_presenter.dart';
import '../presentation/presenters/log_in_page_presenter.dart';
import '../presentation/presenters/picture_page_presenter.dart';
import '../presentation/presenters/profile_page_presenter.dart';
import '../presentation/presenters/register_page_presenter.dart';
import '../presentation/presenters/trainees_page_presenter.dart';

/// Factory object for creating a presenter objects, by attaching the required repositories and datasources.
/// This factory is a singleton object.
class PresenterFactory {
  static final PresenterFactory _instance = PresenterFactory._internal();

  PresenterFactory._internal();

  factory PresenterFactory() {
    return _instance;
  }

  BackendAPI backendAPI = BackendAPI(); // datasource
  NewsAPI newsAPI = NewsAPI(); //datasource

  TokenRepository getTokenRepository() =>
      TokenRepoImpl(backendAPI); // token repository
  UserRepository getUserRepository() =>
      UserRepoImpl(backendAPI); // user repository
  HabitsRepository getHabitsRepository() =>
      HabitsRepoImpl(backendAPI); // habits repository
  NewsRepository getNewsRepository() => NewsRepoImpl(newsAPI); //news repository

  // function to get a LogInPagePresenter object.
  LogInPagePresenter getLogInPresenter() =>
      LogInPagePresenter(getTokenRepository(), getUserRepository());

  // function to get a HomePagePresenter object.
  HabitsPagePresenter getHabitsPagePresenter(String userId) =>
      HabitsPagePresenter(getHabitsRepository(), userId);

  // function to get a EditHomePagePresenter object.
  EditHabitsPagePresenter getEditHabitsPagePresenter(String userId) =>
      EditHabitsPagePresenter(getHabitsRepository(), userId);

  // function to get a HomePagePresenter object.
  HomePagePresenter getHomePagePresenter() =>
      HomePagePresenter(getNewsRepository(), getUserRepository());

  // function to get a PicturePagePresenter object.
  PicturePagePresenter getPicturePagePresenter(String userId) =>
      PicturePagePresenter(getUserRepository(), userId);

  // function to get a HomePagePresenter object.
  ProfilePagePresenter getProfilePagePresenter(String userId) =>
      ProfilePagePresenter(getUserRepository(), userId);

  // function to get a RegisterPagePresenter object.
  RegisterPagePresenter getRegisterPresenter() =>
      RegisterPagePresenter(getUserRepository());

  // function to get a HomePagePresenter object.
  TraineesPagePresenter getTraineesPagePresenter() =>
      TraineesPagePresenter(getUserRepository());
}
