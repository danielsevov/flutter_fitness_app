import 'package:lift_to_live_flutter/data/datasources/backend_api.dart';
import 'package:lift_to_live_flutter/data/repositories/user_repo_impl.dart';
import '../domain/repositories/user_repo.dart';
import '../presentation/presenters/picture_page_presenter.dart';

/// Factory object for creating a PicturePagePresenter object, by attaching the required repositories and datasources.
/// This factory is a singleton object.
class PicturePageFactory {
  static final PicturePageFactory _instance = PicturePageFactory._internal();

  PicturePageFactory._internal();

  factory PicturePageFactory() {
    return _instance;
  }

  BackendAPI backendAPI = BackendAPI(); //datasource

  UserRepository getUserRepository() =>
      UserRepoImpl(backendAPI); // user repository

  // function to get a HomePagePresenter object.
  PicturePagePresenter getPicturePagePresenter(String userId) =>
      PicturePagePresenter(getUserRepository(), userId);
}
