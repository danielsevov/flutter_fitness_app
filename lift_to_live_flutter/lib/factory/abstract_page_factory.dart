import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/edit_habits_page.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/workout_page.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/habits_page.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/picture_page.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/profile_page.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/register_page.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/trainees_page.dart';
import '../presentation/ui/pages/home_page.dart';
import '../presentation/ui/pages/log_in_page.dart';
import '../presentation/ui/pages/workout_history_page.dart';
import '../presentation/ui/pages/workout_templates_page.dart';
import 'abstract_presenter_factory.dart';

/// API to the factory object used for creating a page objects.
abstract class AbstractPageFactory {
  void setPresenterFactory(AbstractPresenterFactory factory);

  /// Function used to get a LogInPage object
  LogInPage getLogInPage();

  /// Function used to get a HomePage object
  HomePage getHomePage();

  /// Function used to get a TraineesPage object
  TraineesPage getTraineesPage();

  /// Function used to get a RegisterPage object
  RegisterPage getRegisterPage();

  /// Function used to get a HabitsPage object
  HabitsPage getHabitsPage(String userId);

  /// Function used to get a EditHabitsPage object
  EditHabitsPage getEditHabitsPage(String userId);

  /// Function used to get a WorkoutHistoryPage object
  WorkoutHistoryPage getWorkoutHistoryPage (String userId);

  /// Function used to get a WorkoutHistoryPage object
  WorkoutTemplatesPage getWorkoutTemplatesPage (String userId);

  /// Function used to get a PicturePage object
  PicturePage getPicturePage(String userId, String name);

  /// Function used to get a ProfilePage object
  ProfilePage getProfilePage(String userId, String originPage);

  /// Function used to get a WorkoutPage object
  WorkoutPage getWorkoutPage(int id, String userId, bool forTemplate, bool fromTemplate);

  /// Function used to get a HomePage object wrapped in a BottomBarController so that the expandable bottom nav bar can be used.
  DefaultBottomBarController getWrappedHomePage();
}
