import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:lift_to_live_flutter/factory/abstract_page_factory.dart';
import 'package:lift_to_live_flutter/factory/abstract_presenter_factory.dart';
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
class PageFactory implements AbstractPageFactory{
  static final PageFactory _instance = PageFactory._internal();

  PageFactory._internal();

  factory PageFactory() {
    return _instance;
  }

  AbstractPresenterFactory _presenterFactory = PresenterFactory();

  @override
  void setPresenterFactory(AbstractPresenterFactory factory) {
    _presenterFactory = factory;
  }

  // function to get a LogInPage object
  @override
  LogInPage getLogInPage() =>
      LogInPage(presenter: _presenterFactory.getLogInPagePresenter(), pageFactory: this,);

  // function to get a HomePage object
  @override
  HomePage getHomePage() =>
      HomePage(presenter: _presenterFactory.getHomePagePresenter(), pageFactory: this,);

  // function to get a TraineesPage object
  @override
  TraineesPage getTraineesPage() =>
      TraineesPage(presenter: _presenterFactory.getTraineesPagePresenter(), pageFactory: this,);

  // function to get a RegisterPage object
  @override
  RegisterPage getRegisterPage() =>
      RegisterPage(presenter: _presenterFactory.getRegisterPagePresenter(), pageFactory: this,);

  // function to get a HabitsPage object
  @override
  HabitsPage getHabitsPage(String userId) => HabitsPage(
        presenter: _presenterFactory.getHabitsPagePresenter(userId),
        userId: userId, pageFactory: this
      );

  // function to get a EditHabitsPage object
  @override
  EditHabitsPage getEditHabitsPage(String userId) => EditHabitsPage(
        presenter: _presenterFactory.getEditHabitsPagePresenter(userId),
        userId: userId, pageFactory: this
      );

  // function to get a WorkoutHistoryPage object
  @override
  WorkoutHistoryPage getWorkoutHistoryPage (String userId) => WorkoutHistoryPage(
    presenter: _presenterFactory.getWorkoutHistoryPresenter(userId),
    userId: userId, pageFactory: this
  );

  // function to get a WorkoutHistoryPage object
  @override
  WorkoutTemplatesPage getWorkoutTemplatesPage (String userId) => WorkoutTemplatesPage(
    presenter: _presenterFactory.getWorkoutTemplatesPagePresenter(userId),
    userId: userId, pageFactory: this
  );

  // function to get a PicturePage object
  @override
  PicturePage getPicturePage(String userId, String name) => PicturePage(
        presenter: _presenterFactory.getPicturePagePresenter(userId),
        userId: userId,
        name: name
      );

  // function to get a ProfilePage object
  @override
  ProfilePage getProfilePage(String userId, String originPage) => ProfilePage(
        presenter: _presenterFactory.getProfilePagePresenter(userId),
        userId: userId,
        originPage: originPage, pageFactory: this
      );

  // function to get a WorkoutPage object
  @override
  WorkoutPage getWorkoutPage(int id, String userId, bool forTemplate, bool fromTemplate) => WorkoutPage(
    presenter: _presenterFactory.getWorkoutPagePresenter(id, userId, forTemplate, fromTemplate),
    templateId: id, userId: userId, forTemplate: forTemplate, fromTemplate: fromTemplate, pageFactory: this
  );

  // function to get a HomePage object wrapped in a BottomBarController so that the expandable bottom nav bar can be used.
  @override
  DefaultBottomBarController getWrappedHomePage() =>
      DefaultBottomBarController(child: getHomePage());
}
