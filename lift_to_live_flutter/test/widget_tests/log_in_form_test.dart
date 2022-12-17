import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/presentation/presenters/log_in_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/forms_and_dialogs/log_in_form.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../widget_tests/log_in_form_test.mocks.dart';

@GenerateMocks([LogInPagePresenter])
void main() {

  testWidgets('LogInForm test constructor', (tester) async {
    await tester.runAsync(() async {
      // tests
      final presenter = MockLogInPagePresenter();

      final form = LogInForm(screenHeight: 800, screenWidth: 400, presenter: presenter);

      final titleFinder = find.text('Sign In');
      final iconFinder = find.byIcon(Icons.email_outlined);
      final icon2Finder = find.byIcon(Icons.key);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: form,))));

      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      expect(titleFinder, findsOneWidget);
      expect(iconFinder, findsOneWidget);
      expect(icon2Finder, findsOneWidget);
    });
  });

  testWidgets('LogInForm test constructor 2', (tester) async {
    await tester.runAsync(() async {
      // tests
      final presenter = MockLogInPagePresenter();

      final form = LogInForm(screenHeight: 400, screenWidth: 800, presenter: presenter);

      final titleFinder = find.text('Sign In');
      final iconFinder = find.byIcon(Icons.email_outlined);
      final icon2Finder = find.byIcon(Icons.key);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: form,))));

      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      expect(titleFinder, findsOneWidget);
      expect(iconFinder, findsOneWidget);
      expect(icon2Finder, findsOneWidget);
    });
  });

  testWidgets('LogInForm test click validation missing email and password', (tester) async {
    await tester.runAsync(() async {
      // tests
      final presenter = MockLogInPagePresenter();

      final form = LogInForm(screenHeight: 800, screenWidth: 400, presenter: presenter);

      final valFinder = find.text('Email must be in the right format (xxx@xxx.xxx)!');
      final val2Finder = find.text('Password must be at least 8 characters long!');
      final buttonFinder = find.text('Sign In');

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: form,))));

      await tester.pump(const Duration(seconds: 2));
      await tester.tap(buttonFinder);
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(valFinder, findsOneWidget);
      expect(val2Finder, findsOneWidget);
    });
  });

  testWidgets('LogInForm test click validation wrong email and missing password', (tester) async {
    await tester.runAsync(() async {
      // tests
      final presenter = MockLogInPagePresenter();

      final form = LogInForm(screenHeight: 800, screenWidth: 400, presenter: presenter);

      final fieldFinder = find.widgetWithIcon(TextFormField, Icons.email_outlined);
      final valFinder = find.text('Email must be in the right format (xxx@xxx.xxx)!');
      final val2Finder = find.text('Password must be at least 8 characters long!');
      final buttonFinder = find.text('Sign In');

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: form,))));

      await tester.pump(const Duration(seconds: 2));
      await tester.enterText(fieldFinder, 'email');
      await tester.pump(const Duration(seconds: 2));
      await tester.tap(buttonFinder);
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(valFinder, findsOneWidget);
      expect(val2Finder, findsOneWidget);
    });
  });

  testWidgets('LogInForm test click validation only password', (tester) async {
    await tester.runAsync(() async {
      // tests
      final presenter = MockLogInPagePresenter();

      final form = LogInForm(screenHeight: 800, screenWidth: 400, presenter: presenter);

      final fieldFinder = find.widgetWithIcon(TextFormField, Icons.email_outlined);
      final valFinder = find.text('Email must be in the right format (xxx@xxx.xxx)!');
      final val2Finder = find.text('Password must be at least 8 characters long!');
      final buttonFinder = find.text('Sign In');

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: form,))));

      await tester.pump(const Duration(seconds: 2));
      await tester.enterText(fieldFinder, 'email@email.com');
      await tester.pump(const Duration(seconds: 2));
      await tester.tap(buttonFinder);
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(valFinder, findsNothing);
      expect(val2Finder, findsOneWidget);
    });
  });

  testWidgets('LogInForm test click validation right email wrong password', (tester) async {
    await tester.runAsync(() async {
      // tests
      final presenter = MockLogInPagePresenter();

      final form = LogInForm(screenHeight: 800, screenWidth: 400, presenter: presenter);

      final fieldEmailFinder = find.widgetWithIcon(TextFormField, Icons.email_outlined);
      final fieldPassFinder = find.widgetWithIcon(TextFormField, Icons.key);
      final valFinder = find.text('Email must be in the right format (xxx@xxx.xxx)!');
      final val2Finder = find.text('Password must be at least 8 characters long!');
      final buttonFinder = find.text('Sign In');

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: form,))));

      await tester.pump(const Duration(seconds: 2));
      await tester.enterText(fieldEmailFinder, 'email@email.com');
      await tester.enterText(fieldPassFinder, 'pass');
      await tester.pump(const Duration(seconds: 2));
      await tester.tap(buttonFinder);
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(valFinder, findsNothing);
      expect(val2Finder, findsOneWidget);
    });
  });

  testWidgets('LogInForm test click validation right email and password', (tester) async {
    await tester.runAsync(() async {
      // tests
      final presenter = MockLogInPagePresenter();

      when(presenter.logIn()).thenAnswer((realInvocation) async => {await Future.delayed(const Duration(seconds: 1))});

      final form = LogInForm(screenHeight: 800, screenWidth: 400, presenter: presenter);

      final fieldEmailFinder = find.widgetWithIcon(TextFormField, Icons.email_outlined);
      final fieldPassFinder = find.widgetWithIcon(TextFormField, Icons.key);
      final valFinder = find.text('Email must be in the right format (xxx@xxx.xxx)!');
      final val2Finder = find.text('Password must be at least 8 characters long!');
      final buttonFinder = find.text('Sign In');

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: form,))));

      await tester.pump(const Duration(seconds: 2));
      await tester.enterText(fieldEmailFinder, 'email@email.com');
      await tester.enterText(fieldPassFinder, 'testpassword');
      await tester.pump(const Duration(seconds: 2));
      await tester.tap(buttonFinder);
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(valFinder, findsNothing);
      expect(val2Finder, findsNothing);
      verify(presenter.logIn()).called(1);
    });
  });

  testWidgets('LogInForm test getters for email and password', (tester) async {
    await tester.runAsync(() async {
      // tests
      final presenter = MockLogInPagePresenter();

      when(presenter.logIn()).thenAnswer((realInvocation) async => {await Future.delayed(const Duration(seconds: 1))});

      final form = LogInForm(screenHeight: 800, screenWidth: 400, presenter: presenter);

      final fieldEmailFinder = find.widgetWithIcon(TextFormField, Icons.email_outlined);
      final fieldPassFinder = find.widgetWithIcon(TextFormField, Icons.key);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: form,))));

      await tester.pump(const Duration(seconds: 2));
      await tester.enterText(fieldEmailFinder, 'email@email.com');
      await tester.enterText(fieldPassFinder, 'testpassword');
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(form.getEmail(), 'email@email.com');
      expect(form.getPassword(), 'testpassword');
    });
  });

  testWidgets('LogInForm test clear password', (tester) async {
    await tester.runAsync(() async {
      // tests
      final presenter = MockLogInPagePresenter();

      when(presenter.logIn()).thenAnswer((realInvocation) async => {await Future.delayed(const Duration(seconds: 1))});

      final form = LogInForm(screenHeight: 800, screenWidth: 400, presenter: presenter);

      final fieldEmailFinder = find.widgetWithIcon(TextFormField, Icons.email_outlined);
      final fieldPassFinder = find.widgetWithIcon(TextFormField, Icons.key);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: form,))));

      await tester.pump(const Duration(seconds: 2));
      await tester.enterText(fieldEmailFinder, 'email@email.com');
      await tester.enterText(fieldPassFinder, 'testpassword');
      await tester.pump(const Duration(seconds: 1));

      form.clearPassword();

      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      expect(form.getEmail(), 'email@email.com');
      expect(form.getPassword(), '');
    });
  });

  testWidgets('LogInForm test clear form', (tester) async {
    await tester.runAsync(() async {
      // tests
      final presenter = MockLogInPagePresenter();

      when(presenter.logIn()).thenAnswer((realInvocation) async => {await Future.delayed(const Duration(seconds: 1))});

      final form = LogInForm(screenHeight: 800, screenWidth: 400, presenter: presenter);

      final fieldEmailFinder = find.widgetWithIcon(TextFormField, Icons.email_outlined);
      final fieldPassFinder = find.widgetWithIcon(TextFormField, Icons.key);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(body: Center(child: form,))));

      await tester.pump(const Duration(seconds: 2));
      await tester.enterText(fieldEmailFinder, 'email@email.com');
      await tester.enterText(fieldPassFinder, 'testpassword');
      await tester.pump(const Duration(seconds: 1));
      form.clearForm();
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      expect(form.getEmail(), '');
      expect(form.getPassword(), '');
    });
  });
}
