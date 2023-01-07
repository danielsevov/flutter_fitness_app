import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/factory/page_factory.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/edit_habits_page.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/habits_page.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/home_page.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/log_in_page.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/picture_page.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/profile_page.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/register_page.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/trainees_page.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/workout_history_page.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/workout_page.dart';
import 'package:lift_to_live_flutter/presentation/ui/pages/workout_templates_page.dart';

void main() {
  test('PageFactory.getHomePage() test', () {
    var page = PageFactory().getHomePage();
    expect(page, isA<HomePage>());
  });

  test('PageFactory.getLogInPage() test', () {
    var page = PageFactory().getLogInPage();
    expect(page, isA<LogInPage>());
  });

  test('PageFactory.getRegisterPage() test', () {
    var page = PageFactory().getRegisterPage();
    expect(page, isA<RegisterPage>());
  });

  test('PageFactory.getTraineesPage() test', () {
    var page = PageFactory().getTraineesPage();
    expect(page, isA<TraineesPage>());
  });

  test('PageFactory.getHabitsPage() test', () {
    var page = PageFactory().getHabitsPage('');
    expect(page, isA<HabitsPage>());
  });

  test('PageFactory.getEditHabitsPage() test', () {
    var page = PageFactory().getEditHabitsPage('');
    expect(page, isA<EditHabitsPage>());
  });

  test('PageFactory.getPicturePage() test', () {
    var page = PageFactory().getPicturePage('', '');
    expect(page, isA<PicturePage>());
  });

  test('PageFactory.getProfilePage() test', () {
    var page = PageFactory().getProfilePage('', '');
    expect(page, isA<ProfilePage>());
  });

  test('PageFactory.getWorkoutPage() test', () {
    var page = PageFactory().getWorkoutPage(1, '', false, false);
    expect(page, isA<WorkoutPage>());
  });

  test('PageFactory.getWorkoutHistoryPage() test', () {
    var page = PageFactory().getWorkoutHistoryPage('');
    expect(page, isA<WorkoutHistoryPage>());
  });

  test('PageFactory.getWorkoutTemplatesPage() test', () {
    var page = PageFactory().getWorkoutTemplatesPage('');
    expect(page, isA<WorkoutTemplatesPage>());
  });
  
  test('PageFactory.getWrappedHomePage() test', () {
    var page = PageFactory().getWrappedHomePage();
    expect(page, isA<DefaultBottomBarController>());
  });
}
