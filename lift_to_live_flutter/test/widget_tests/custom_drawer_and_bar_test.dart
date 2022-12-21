import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/helper.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/custom_bottom_nav_bar/custom_bottom_bar.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/custom_drawer/custom_drawer.dart';
import 'package:lift_to_live_flutter/presentation/views/home_page_view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../test_data.dart';
import 'custom_drawer_and_bar_test.mocks.dart';

@GenerateMocks([HomePageView])
void main() {
  testWidgets('CustomDrawer test constructor', (tester) async {
    await tester.runAsync(() async {
      // tests
      final HomePageView view = MockHomePageView();
      when(view.screenWidth).thenReturn(400);
      when(view.screenHeight).thenReturn(400);
      when(view.isFetched).thenReturn(true);
      when(view.userData).thenReturn(TestData.testUser1);
      when(view.profilePicture).thenReturn(Image.asset(
          'assets/images/prof_pic.png',
          height: 100));

      final widget = CustomDrawer(view: view);

      final nameFinder = find.text('Test User');
      final accountFinder = find.text('My Profile');
      final habitFinder = find.text('My Habits');
      final workoutFinder = find.text('Manage Workouts');

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(height: 400, width: 400, color: Helper.blueColor,child: widget),))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(nameFinder, findsOneWidget);
      expect(accountFinder, findsOneWidget);
      expect(habitFinder, findsOneWidget);
      expect(workoutFinder, findsOneWidget);

      await tester.tap(accountFinder);
      await tester.tap(habitFinder);
      await tester.tap(workoutFinder);
    });
  });

  testWidgets('CustomDrawer test constructor', (tester) async {
    await tester.runAsync(() async {
      // tests
      final HomePageView view = MockHomePageView();
      when(view.screenWidth).thenReturn(400);
      when(view.screenHeight).thenReturn(400);
      when(view.isFetched).thenReturn(false);
      when(view.userData).thenReturn(TestData.testUser1);
      when(view.profilePicture).thenReturn(Image.asset(
          'assets/images/prof_pic.png',
          height: 100));

      final widget = CustomDrawer(view: view);

      final nameFinder = find.text('Test User');
      final accountFinder = find.text('My Profile');
      final habitFinder = find.text('My Habits');
      final workoutFinder = find.text('Manage Workouts');

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(height: 400, width: 400, color: Helper.blueColor,child: widget),))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(nameFinder, findsNothing);
      expect(accountFinder, findsOneWidget);
      expect(habitFinder, findsOneWidget);
      expect(workoutFinder, findsOneWidget);
    });
  });

  testWidgets('CustomDrawer test tap', (tester) async {
    await tester.runAsync(() async {
      // tests
      final HomePageView view = MockHomePageView();
      when(view.screenWidth).thenReturn(400);
      when(view.screenHeight).thenReturn(600);
      when(view.isFetched).thenReturn(true);
      when(view.userData).thenReturn(TestData.testUser1);
      when(view.profilePicture).thenReturn(Image.asset(
          'assets/images/prof_pic.png',
          height: 100));

      final widget = CustomDrawer(view: view);

      final nameFinder = find.text('Test User');
      final accountFinder = find.text('My Profile');
      final habitFinder = find.text('My Habits');
      final workoutFinder = find.text('Manage Workouts');
      final traineesFinder = find.text('Manage Trainees');

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: Container(height: 600, width: 400, color: Helper.blueColor,child: widget),))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(nameFinder, findsOneWidget);
      expect(accountFinder, findsOneWidget);
      expect(habitFinder, findsOneWidget);
      expect(workoutFinder, findsOneWidget);
      expect(traineesFinder, findsOneWidget);

      await tester.tap(traineesFinder);
      await tester.tap(accountFinder);
      await tester.tap(habitFinder);
      await tester.tap(workoutFinder);
    });
  });


  testWidgets('CustomBottomBar test constructor', (tester) async {
    await tester.runAsync(() async {
      // tests
      final HomePageView view = MockHomePageView();
      when(view.screenWidth).thenReturn(400);
      when(view.screenHeight).thenReturn(400);
      when(view.isFetched).thenReturn(true);
      when(view.userData).thenReturn(TestData.testUser1);
      when(view.profilePicture).thenReturn(Image.asset(
          'assets/images/prof_pic.png',
          height: 100));

      final widget = CustomBottomBar(view: view);

      final accountFinder = find.text('Profile');
      final habitFinder = find.text('Habits');
      final calendarFinder = find.text('Calendar');
      final traineesFinder = find.text('Trainees');

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: DefaultBottomBarController(child: Scaffold(body: Center(child: Container(height: 400, width: 400, color: Helper.blueColor,child: widget),)))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(calendarFinder, findsOneWidget);
      expect(accountFinder, findsOneWidget);
      expect(habitFinder, findsOneWidget);
      expect(traineesFinder, findsOneWidget);

      await tester.tap(accountFinder);
      await tester.tap(habitFinder);
      await tester.tap(calendarFinder);
      await tester.tap(traineesFinder);
    });
  });

  // TODO fix expandable test
  // testWidgets('CustomBottomBar test expand', (tester) async {
  //   await tester.runAsync(() async {
  //     // tests
  //     final HomePageView view = MockHomePageView();
  //     when(view.screenWidth).thenReturn(400);
  //     when(view.screenHeight).thenReturn(400);
  //     when(view.isFetched).thenReturn(true);
  //     when(view.userData).thenReturn(TestData.test_user_1);
  //     when(view.profilePicture).thenReturn(Image.asset(
  //         'assets/images/prof_pic.png',
  //         height: 100));
  //
  //     final widget = CustomBottomBar(view: view);
  //
  //     final buttonFinder1 = find.text('Start Workout').hitTestable();
  //     final buttonFinder2 = find.text('Edit Templates').hitTestable();
  //     final buttonFinder3 = find.text('View History').hitTestable();
  //     final iconFinder = find.byKey(Key('expandButton'));
  //
  //     await tester.pumpWidget(MaterialApp(
  //         title: 'Flutter Demo', home: DefaultBottomBarController(child: Scaffold(body: Center(child: Container(height: 400, width: 400, color: Helper.blueColor,child: widget),)))));
  //
  //     await tester.pumpAndSettle();
  //     await tester.pump(const Duration(seconds: 2));
  //
  //     expect(buttonFinder1, findsNothing);
  //     expect(buttonFinder2, findsNothing);
  //     expect(buttonFinder3, findsNothing);
  //
  //     await tester.pumpAndSettle();
  //     await tester.pump(const Duration(seconds: 2));
  //
  //     await tester.tap(iconFinder);
  //
  //     await tester.pumpAndSettle();
  //     await tester.pump(const Duration(seconds: 2));
  //
  //     expect(buttonFinder1, findsOneWidget);
  //     expect(buttonFinder2, findsOneWidget);
  //     expect(buttonFinder3, findsOneWidget);
  //   });
  // });
}
