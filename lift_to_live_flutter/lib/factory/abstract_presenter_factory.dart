import 'package:lift_to_live_flutter/domain/repositories/exercise_repo.dart';
import 'package:lift_to_live_flutter/domain/repositories/habits_repo.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:lift_to_live_flutter/domain/repositories/workout_repo.dart';
import 'package:lift_to_live_flutter/presentation/presenters/workout_history_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/presenters/workout_templates_page_presenter.dart';
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

/// API to the factory object for creating a presenter objects, by attaching the required repositories and datasources.
abstract class AbstractPresenterFactory {
  TokenRepository getTokenRepository(); // token repository
  UserRepository getUserRepository(); // user repository
  HabitsRepository getHabitsRepository(); // habits repository
  NewsRepository getNewsRepository(); //news repository
  ExerciseRepository getExerciseRepository(); //exercise repository
  WorkoutRepository getWorkoutRepository(); //workouts repository

  // function to get a LogInPagePresenter object.
  LogInPagePresenter getLogInPagePresenter();

  // function to get a RegisterPagePresenter object.
  RegisterPagePresenter getRegisterPagePresenter();

  // function to get a TraineesPagePresenter object.
  TraineesPagePresenter getTraineesPagePresenter();

  // function to get a HomePagePresenter object.
  ProfilePagePresenter getProfilePagePresenter(String userId);

  // function to get a PicturePagePresenter object.
  PicturePagePresenter getPicturePagePresenter(String userId);

  // function to get a HomePagePresenter object.
  HomePagePresenter getHomePagePresenter();

  // function to get a HabitsPagePresenter object.
  HabitsPagePresenter getHabitsPagePresenter(String userId);

  // function to get a EditHabitsPagePresenter object.
  EditHabitsPagePresenter getEditHabitsPagePresenter(String userId);

  // function to get a WorkoutHistoryPagePresenter object.
  WorkoutHistoryPagePresenter getWorkoutHistoryPresenter(String userId);

  // function to get a WorkoutTemplatesPagePresenter object.
  WorkoutTemplatesPagePresenter getWorkoutTemplatesPagePresenter(String userId);

  // function to get a WorkoutPagePresenter object.
  WorkoutPagePresenter getWorkoutPagePresenter(int templateId, String userId, bool forTemplate, bool fromTemplate);

  void reset();
}
