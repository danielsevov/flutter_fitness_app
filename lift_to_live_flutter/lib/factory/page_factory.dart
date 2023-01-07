import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:lift_to_live_flutter/factory/presenter_factory.dart';
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

/// Factory object for creating a page objects.
/// This factory is a singleton object.
class PageFactory {
  static final PageFactory _instance = PageFactory._internal();

  PageFactory._internal();

  factory PageFactory() {
    return _instance;
  }

  final PresenterFactory _presenterFactory = PresenterFactory();

  // function to get a LogInPage object
  LogInPage getLogInPage() =>
      LogInPage(presenter: _presenterFactory.getLogInPagePresenter());

  // function to get a HomePage object
  HomePage getHomePage() =>
      HomePage(presenter: _presenterFactory.getHomePagePresenter());

  // function to get a TraineesPage object
  TraineesPage getTraineesPage() =>
      TraineesPage(presenter: _presenterFactory.getTraineesPagePresenter());

  // function to get a RegisterPage object
  RegisterPage getRegisterPage() =>
      RegisterPage(presenter: _presenterFactory.getRegisterPagePresenter());

  // function to get a HabitsPage object
  HabitsPage getHabitsPage(String userId) => HabitsPage(
        presenter: _presenterFactory.getHabitsPagePresenter(userId),
        userId: userId,
      );

  // function to get a EditHabitsPage object
  EditHabitsPage getEditHabitsPage(String userId) => EditHabitsPage(
        presenter: _presenterFactory.getEditHabitsPagePresenter(userId),
        userId: userId,
      );

  // function to get a WorkoutHistoryPage object
  WorkoutHistoryPage getWorkoutHistoryPage (String userId) => WorkoutHistoryPage(
    presenter: _presenterFactory.getWorkoutHistoryPresenter(userId),
    userId: userId,
  );

  // function to get a WorkoutHistoryPage object
  WorkoutTemplatesPage getWorkoutTemplatesPage (String userId) => WorkoutTemplatesPage(
    presenter: _presenterFactory.getWorkoutTemplatesPagePresenter(userId),
    userId: userId,
  );

  // function to get a PicturePage object
  PicturePage getPicturePage(String userId, String name) => PicturePage(
        presenter: _presenterFactory.getPicturePagePresenter(userId),
        userId: userId,
        name: name,
      );

  // function to get a ProfilePage object
  ProfilePage getProfilePage(String userId, String originPage) => ProfilePage(
        presenter: _presenterFactory.getProfilePagePresenter(userId),
        userId: userId,
        originPage: originPage,
      );

  // function to get a WorkoutPage object
  WorkoutPage getWorkoutPage(int id, String userId, bool forTemplate, bool fromTemplate) => WorkoutPage(
    presenter: _presenterFactory.getWorkoutPagePresenter(id, userId, forTemplate, fromTemplate),
    templateId: id, userId: userId, forTemplate: forTemplate, fromTemplate: fromTemplate,
  );

  // function to get a HomePage object wrapped in a BottomBarController so that the expandable bottom nav bar can be used.
  DefaultBottomBarController getWrappedHomePage() =>
      DefaultBottomBarController(child: getHomePage());
}
