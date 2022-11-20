import 'package:lift_to_live_flutter/data/datasources/backend_api.dart';
import 'package:lift_to_live_flutter/data/repositories/user_repo_impl.dart';
import 'package:lift_to_live_flutter/presentation/presenters/profile_page_presenter.dart';
import '../domain/repositories/user_repo.dart';

/// Factory object for creating a ProfilePagePresenter object, by attaching the required repositories and datasources.
/// This factory is a singleton object.
class ProfilePageFactory {
  static final ProfilePageFactory _instance = ProfilePageFactory._internal();

  ProfilePageFactory._internal();

  factory ProfilePageFactory() {
    return _instance;
  }

  BackendAPI backendAPI = BackendAPI(); //datasource

  UserRepository getUserRepository() =>
      UserRepoImpl(backendAPI); // user repository

  // function to get a HomePagePresenter object.
  ProfilePagePresenter getProfilePagePresenter(String userId) =>
      ProfilePagePresenter(getUserRepository(), userId);
}
