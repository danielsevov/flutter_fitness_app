import 'package:lift_to_live_flutter/data/datasources/backend_api.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';

import '../data/repositories/user_repo_impl.dart';
import '../presentation/presenters/register_page_presenter.dart';

/// Factory object for creating a RegisterPagePresenter object, by attaching the required repositories and datasources.
/// This factory is a singleton object.
class RegisterPageFactory {
  static final RegisterPageFactory _instance = RegisterPageFactory._internal();

  RegisterPageFactory._internal();

  factory RegisterPageFactory() {
    return _instance;
  }

  BackendAPI backendAPI = BackendAPI(); // datasource

  UserRepository getUserRepository() =>
      UserRepoImpl(backendAPI); // user repository

  // function to get a RegisterPagePresenter object.
  RegisterPagePresenter getRegisterPresenter() =>
      RegisterPagePresenter(getUserRepository());
}
