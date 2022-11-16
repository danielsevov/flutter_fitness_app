import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/log_out_dialog.dart';
import 'package:lift_to_live_flutter/presentation/views/home_page_view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../presenter_tests/home_page_presenter_test.mocks.dart';

@GenerateMocks([HomePageView])
void main() {

  testWidgets('LogOutDialog test constructor', (tester) async {
    await tester.runAsync(() async {
      // tests
      final view = MockHomePageView();
      var dialog = LogOutDialog(view: view);

      final titleFinder = find.text('Sign out');
      final messageFinder = find.text('Are you sure you want to sign out?');
      final iconFinder = find.byIcon(Icons.check_circle);
      final icon2Finder = find.byIcon(Icons.cancel);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: dialog)));

      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      expect(titleFinder, findsOneWidget);
      expect(messageFinder, findsOneWidget);
      expect(iconFinder, findsOneWidget);
      expect(icon2Finder, findsOneWidget);
    });
  });

  testWidgets('LogOutDialog cancel test', (tester) async {
    await tester.runAsync(() async {
      final view = MockHomePageView();
      var dialog = LogOutDialog(view: view);

      when(view.logOutPressed(any)).thenAnswer((realInvocation) { Navigator.pop(realInvocation.positionalArguments[0]!);});

      final titleFinder = find.text('Sign out');
      final messageFinder = find.text('Are you sure you want to sign out?');
      final iconFinder = find.byIcon(Icons.check_circle);
      final icon2Finder = find.byIcon(Icons.cancel);

      await tester.pumpWidget(MaterialApp(
      title: 'Flutter Demo', home: Scaffold(body: dialog)));

      await tester.pump(const Duration(seconds: 2));

      await tester.tap(icon2Finder);

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(titleFinder, findsNothing);
      expect(messageFinder, findsNothing);
      expect(iconFinder, findsNothing);
      expect(icon2Finder, findsNothing);
      verifyNever(view.logOutPressed(any));
    });
  });

  testWidgets('LogOutDialog accept test', (tester) async {
    await tester.runAsync(() async {
      // tests

      final view = MockHomePageView();
      var dialog = LogOutDialog(view: view);

      when(view.logOutPressed(any)).thenAnswer((realInvocation) { Navigator.pop(realInvocation.positionalArguments[0]!);});

      final titleFinder = find.text('Sign out');
      final messageFinder = find.text('Are you sure you want to sign out?');
      final iconFinder = find.byIcon(Icons.check_circle);
      final icon2Finder = find.byIcon(Icons.cancel);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: dialog)));

      await tester.pump(const Duration(seconds: 2));

      await tester.tap(iconFinder);

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(titleFinder, findsNothing);
      expect(messageFinder, findsNothing);
      expect(iconFinder, findsNothing);
      expect(icon2Finder, findsNothing);
      verify(view.logOutPressed(any)).called(1);
    });
  });
}
