import 'package:lift_to_live_flutter/data/datasources/backend_api.dart';
import 'package:lift_to_live_flutter/data/repositories/user_repo_impl.dart';
import '../domain/repositories/user_repo.dart';
import '../presentation/presenters/trainees_page_presenter.dart';

/// Factory object for creating a TraineesPagePresenter object, by attaching the required repositories and datasources.
/// This factory is a singleton object.
class TraineesPageFactory {
  static final TraineesPageFactory _instance = TraineesPageFactory._internal();

  TraineesPageFactory._internal();

  factory TraineesPageFactory() {
    return _instance;
  }

  BackendAPI backendAPI = BackendAPI(); //datasource

  UserRepository getUserRepository() =>
      UserRepoImpl(backendAPI); // user repository

  // function to get a HomePagePresenter object.
  TraineesPagePresenter getTraineesPagePresenter() =>
      TraineesPagePresenter(getUserRepository());
}
