import 'package:lift_to_live_flutter/data/datasources/backend_api.dart';
import 'package:lift_to_live_flutter/data/repositories/habits_repo_impl.dart';

import '../presentation/presenters/edit_habits_page_presenter.dart';
import '../presentation/presenters/habits_page_presenter.dart';

/// Factory object for creating a HabitsPagePresenter and EditHabitsPagePresenter objects, by attaching the required repositories and datasources.
/// This factory is a singleton object.
class HabitsPageFactory {
  static final HabitsPageFactory _instance = HabitsPageFactory._internal();

  HabitsPageFactory._internal();

  factory HabitsPageFactory() {
    return _instance;
  }

  BackendAPI backendAPI = BackendAPI(); //datasource

  HabitsRepoImpl getHabitsRepository() =>
      HabitsRepoImpl(backendAPI); // habits repository

  // function to get a HomePagePresenter object.
  HabitsPagePresenter getHabitsPagePresenter(String userId) =>
    HabitsPagePresenter(getHabitsRepository(), userId);

  // function to get a EditHomePagePresenter object.
  EditHabitsPagePresenter getEditHabitsPagePresenter(String userId) =>
      EditHabitsPagePresenter(getHabitsRepository(), userId);
}
