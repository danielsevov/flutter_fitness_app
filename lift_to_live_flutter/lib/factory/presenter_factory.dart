import 'package:lift_to_live_flutter/data/datasources/backend_api.dart';
import 'package:lift_to_live_flutter/data/repositories/exercise_repo_impl.dart';
import 'package:lift_to_live_flutter/data/repositories/workout_repo_impl.dart';
import 'package:lift_to_live_flutter/domain/repositories/exercise_repo.dart';
import 'package:lift_to_live_flutter/domain/repositories/habits_repo.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:lift_to_live_flutter/domain/repositories/workout_repo.dart';
import 'package:lift_to_live_flutter/factory/abstract_presenter_factory.dart';
import 'package:lift_to_live_flutter/presentation/presenters/workout_history_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/presenters/workout_templates_page_presenter.dart';

import '../data/datasources/news_api.dart';
import '../data/repositories/habits_repo_impl.dart';
import '../data/repositories/news_repo_impl.dart';
import '../data/repositories/token_repo_impl.dart';
import '../data/repositories/user_repo_impl.dart';
import '../domain/repositories/news_repo.dart';
import '../domain/repositories/token_repo.dart';
import '../presentation/presenters/edit_habits_page_presenter.dart';
import '../presentation/presenters/workout_page_presenter.dart';
import '../presentation/presenters/habits_page_presenter.dart';
import '../presentation/presenters/home_page_presenter.dart';
import '../presentation/presenters/log_in_page_presenter.dart';
import '../presentation/presenters/picture_page_presenter.dart';
import '../presentation/presenters/profile_page_presenter.dart';
import '../presentation/presenters/register_page_presenter.dart';
import '../presentation/presenters/trainees_page_presenter.dart';

/// Factory object for creating a presenter objects, by attaching the required repositories and datasources.
/// This factory is a singleton object.
class PresenterFactory implements AbstractPresenterFactory{
  static final PresenterFactory _instance = PresenterFactory._internal();

  PresenterFactory._internal();

  factory PresenterFactory() {
    return _instance;
  }

  BackendAPI backendAPI = BackendAPI(); // datasource
  NewsAPI newsAPI = NewsAPI(); //datasource

  @override
  TokenRepository getTokenRepository() =>
      TokenRepoImpl(backendAPI); // token repository
  @override
  UserRepository getUserRepository() =>
      UserRepoImpl(backendAPI); // user repository
  @override
  HabitsRepository getHabitsRepository() =>
      HabitsRepoImpl(backendAPI); // habits repository
  @override
  NewsRepository getNewsRepository() =>
      NewsRepoImpl(newsAPI); //news repository
  @override
  ExerciseRepository getExerciseRepository() =>
      ExerciseRepoImpl(); //exercise repository
  @override
  WorkoutRepository getWorkoutRepository() =>
      WorkoutRepoImpl(backendAPI); //workouts repository

  // reusable presenters
  LogInPagePresenter logInPagePresenter = LogInPagePresenter();
  RegisterPagePresenter registerPagePresenter = RegisterPagePresenter();
  TraineesPagePresenter traineesPagePresenter = TraineesPagePresenter();
  PicturePagePresenter picturePagePresenter = PicturePagePresenter();
  HomePagePresenter homePagePresenter = HomePagePresenter();
  HabitsPagePresenter habitsPagePresenter = HabitsPagePresenter();
  EditHabitsPagePresenter editHabitsPagePresenter = EditHabitsPagePresenter();
  ProfilePagePresenter profilePagePresenter = ProfilePagePresenter();
  WorkoutHistoryPagePresenter workoutHistoryPagePresenter = WorkoutHistoryPagePresenter();
  WorkoutTemplatesPagePresenter workoutTemplatesPagePresenter = WorkoutTemplatesPagePresenter();
  WorkoutPagePresenter workoutPagePresenter = WorkoutPagePresenter();

  // function to get a LogInPagePresenter object.
  @override
  LogInPagePresenter getLogInPagePresenter() {
    if(!logInPagePresenter.repositoriesAttached) {
      logInPagePresenter.attachRepositories(getTokenRepository(), getUserRepository());
    }

    return logInPagePresenter;
  }

  // function to get a RegisterPagePresenter object.
  @override
  RegisterPagePresenter getRegisterPagePresenter() {
    if(!registerPagePresenter.repositoriesAttached) {
      registerPagePresenter.attachRepositories(getUserRepository());
    }

    return registerPagePresenter;
  }

  // function to get a TraineesPagePresenter object.
  @override
  TraineesPagePresenter getTraineesPagePresenter() {
    if(!traineesPagePresenter.repositoriesAttached) {
      traineesPagePresenter.attachRepositories(getUserRepository());
    }

    return traineesPagePresenter;
  }

  // function to get a HomePagePresenter object.
  @override
  ProfilePagePresenter getProfilePagePresenter(String userId){
    if(!profilePagePresenter.repositoriesAttached) {
      profilePagePresenter.attachRepositories(getUserRepository());
    }

    if(profilePagePresenter.userId != userId) {
      profilePagePresenter.reset();
      profilePagePresenter.userId = userId;
    }
    return profilePagePresenter;
  }

  // function to get a PicturePagePresenter object.
  @override
  PicturePagePresenter getPicturePagePresenter(String userId) {
    if(!picturePagePresenter.repositoriesAttached) {
      picturePagePresenter.attachRepositories(getUserRepository());
    }

    picturePagePresenter.changeUser(userId);

    return picturePagePresenter;
  }

  // function to get a HomePagePresenter object.
  @override
  HomePagePresenter getHomePagePresenter() {
    if(!homePagePresenter.repositoriesAttached) {
      homePagePresenter.attachRepositories(getUserRepository(), getNewsRepository());
    }

    return homePagePresenter;
  }

  // function to get a HabitsPagePresenter object.
  @override
  HabitsPagePresenter getHabitsPagePresenter(String userId) {
    if(!habitsPagePresenter.repositoriesAttached) {
      habitsPagePresenter.attachRepositories(getHabitsRepository());
    }

    habitsPagePresenter.changeUser(userId);

    return habitsPagePresenter;
  }

  // function to get a EditHabitsPagePresenter object.
  @override
  EditHabitsPagePresenter getEditHabitsPagePresenter(String userId) {
    if(!editHabitsPagePresenter.repositoriesAttached) {
      editHabitsPagePresenter.attachRepositories(getHabitsRepository());
    }

    editHabitsPagePresenter.changeUser(userId);

    return editHabitsPagePresenter;
  }

  // function to get a WorkoutHistoryPagePresenter object.
  @override
  WorkoutHistoryPagePresenter getWorkoutHistoryPresenter(String userId) {
    if(!workoutHistoryPagePresenter.repositoriesAttached) {
      workoutHistoryPagePresenter.attachRepositories(getWorkoutRepository(), getExerciseRepository());
    }

    workoutHistoryPagePresenter.changeUser(userId);

    return workoutHistoryPagePresenter;
  }

  // function to get a WorkoutTemplatesPagePresenter object.
  @override
  WorkoutTemplatesPagePresenter getWorkoutTemplatesPagePresenter(String userId) {
    if(!workoutTemplatesPagePresenter.repositoriesAttached) {
      workoutTemplatesPagePresenter.attachRepositories(getWorkoutRepository(), getExerciseRepository());
    }

    workoutTemplatesPagePresenter.changeUser(userId);

    return workoutTemplatesPagePresenter;
  }

  // function to get a WorkoutPagePresenter object.
  @override
  WorkoutPagePresenter getWorkoutPagePresenter(int templateId, String userId, bool forTemplate, bool fromTemplate) {
    if(!workoutPagePresenter.repositoriesAttached) {
      workoutPagePresenter.attachRepositories(getWorkoutRepository(), getExerciseRepository());
    }

    workoutPagePresenter.changeTemplate(templateId, userId, forTemplate, fromTemplate);

    return workoutPagePresenter;
  }

  @override
  void reset() {
    homePagePresenter.reset();
    profilePagePresenter.reset();
  }
}
