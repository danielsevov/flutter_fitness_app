import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/entities/role.dart';
import 'package:lift_to_live_flutter/helper.dart';
import 'package:lift_to_live_flutter/presentation/presenters/register_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/state_management/app_state.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/forms_and_dialogs/register_form.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'register_form_test.mocks.dart';

@GenerateMocks([RegisterPagePresenter])
void main() {

  testWidgets('RegisterForm test constructor', (tester) async {
    await tester.runAsync(() async {
      // tests
      final presenter = MockRegisterPagePresenter();
      final appState = AppState();
      appState.setInitialState('User A', 'token', [Role('User A', 'coach')]);
      when(presenter.appState).thenReturn(appState);

      final form = RegisterForm(screenHeight: 600, screenWidth: 400, presenter: presenter, coaches: const ['User A', 'User B', 'User C'],);

      final titleFinder = find.text('Register User');
      final emailFinder = find.byIcon(Icons.email_outlined);
      final passwordFinder = find.byIcon(Icons.key);
      final nameFinder = find.byIcon(Icons.person);
      final locationFinder = find.byIcon(Icons.location_pin);
      final phoneFinder = find.byIcon(Icons.phone);
      final dateFinder = find.byIcon(Icons.date_range);
      final coachFinder = find.byIcon(Icons.fitness_center);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(backgroundColor: Helper.lightBlueColor, body: Center(child: form,))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(titleFinder, findsOneWidget);
      expect(nameFinder, findsOneWidget);
      expect(emailFinder, findsOneWidget);
      expect(passwordFinder, findsOneWidget);
      expect(locationFinder, findsOneWidget);
      expect(phoneFinder, findsOneWidget);
      expect(dateFinder, findsOneWidget);
      expect(coachFinder, findsOneWidget);
    });
  });

  testWidgets('RegisterForm test validator', (tester) async {
    await tester.runAsync(() async {
      // tests
      final presenter = MockRegisterPagePresenter();
      final appState = AppState();
      appState.setInitialState('User A', 'token', [Role('User A', 'coach')]);
      when(presenter.appState).thenReturn(appState);

      final form = RegisterForm(screenHeight: 600, screenWidth: 400, presenter: presenter, coaches: const ['User A', 'User B', 'User C'],);

      final titleFinder = find.text('Register User');
      final emailFinder = find.text('Email must be in the right format (xxx@xxx.xxx)!');
      final passwordFinder = find.text('Password must be at least 8 characters long!');
      final nameFinder = find.text('Name has to be entered!');
      final locationFinder = find.text('Nationality has to be entered!');
      final phoneFinder = find.text('Valid phone number has to be entered!');
      final dateFinder = find.text('Valid date of birth has to be entered!');

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(backgroundColor: Helper.lightBlueColor, body: Center(child: form,))));

      await tester.pump(const Duration(seconds: 2));

      expect(nameFinder, findsNothing);
      expect(emailFinder, findsNothing);
      expect(passwordFinder, findsNothing);
      expect(locationFinder, findsNothing);
      expect(phoneFinder, findsNothing);
      expect(dateFinder, findsNothing);

      await tester.tap(titleFinder);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 2));


      expect(nameFinder, findsOneWidget);
      expect(emailFinder, findsOneWidget);
      expect(passwordFinder, findsOneWidget);
      expect(locationFinder, findsOneWidget);
      expect(phoneFinder, findsOneWidget);
      expect(dateFinder, findsOneWidget);
    });
  });

  testWidgets('RegisterForm test fill coach fields', (tester) async {
    await tester.runAsync(() async {
      // tests
      final presenter = MockRegisterPagePresenter();
      final appState = AppState();
      appState.setInitialState('User A', 'token', [Role('User A', 'coach')]);
      when(presenter.appState).thenReturn(appState);

      final form = RegisterForm(screenHeight: 600, screenWidth: 400, presenter: presenter, coaches: const ['User A', 'User B', 'User C'],);

      final userAFinder = find.text('User A');
      final userBFinder = find.text('User B').first;

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(backgroundColor: Helper.lightBlueColor, body: Center(child: form,))));

      await tester.pump(const Duration(seconds: 2));

      expect(userAFinder, findsOneWidget);

      await tester.tap(userAFinder);

      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 2));

       await tester.tap(userBFinder);

      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 2));

      expect(userBFinder, findsOneWidget);
    });
  });

  testWidgets('RegisterForm test fill location fields', (tester) async {
    await tester.runAsync(() async {
      // tests
      final presenter = MockRegisterPagePresenter();
      final appState = AppState();
      appState.setInitialState('User A', 'token', [Role('User A', 'coach')]);
      when(presenter.appState).thenReturn(appState);

      final form = RegisterForm(screenHeight: 600, screenWidth: 400, presenter: presenter, coaches: const ['User A', 'User B', 'User C'],);

      final locationFinder = find.byIcon(Icons.location_pin);
      final nameFinder = find.text('Austria');

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(backgroundColor: Helper.lightBlueColor, body: Center(child: form,))));

      await tester.pump(const Duration(seconds: 2));

      expect(locationFinder, findsOneWidget);
      expect(nameFinder, findsNothing);

      await tester.tap(locationFinder);

      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 2));

      await tester.tap(nameFinder);

      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 2));

      expect(nameFinder, findsOneWidget);
    });
  });

  testWidgets('RegisterForm test fill date fields', (tester) async {
    await tester.runAsync(() async {
      // tests
      final presenter = MockRegisterPagePresenter();
      final appState = AppState();
      appState.setInitialState('User A', 'token', [Role('User A', 'coach')]);
      when(presenter.appState).thenReturn(appState);

      final form = RegisterForm(screenHeight: 600, screenWidth: 400, presenter: presenter, coaches: const ['User A', 'User B', 'User C'],);

      final locationFinder = find.byIcon(Icons.date_range);
      final nameFinder = find.text('10');

      String month = DateTime.now().month.toString();
      String year = DateTime.now().year.toString();
      if(DateTime.now().month < 10) {
        month = '0$month';
      }
      final dateFinder = find.textContaining('10/$month/$year');
      final buttonFinder = find.text('OK');

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(backgroundColor: Helper.lightBlueColor, body: Center(child: form,))));

      await tester.pump(const Duration(seconds: 2));

      expect(locationFinder, findsOneWidget);
      expect(nameFinder, findsNothing);

      await tester.tap(locationFinder);

      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 2));

      await tester.tap(nameFinder);

      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 2));

      await tester.tap(buttonFinder);

      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 2));

      expect(dateFinder, findsOneWidget);
    });
  });

  testWidgets('RegisterForm test fill all fields', (tester) async {
    await tester.runAsync(() async {
      // tests
      final presenter = MockRegisterPagePresenter();
      final appState = AppState();
      appState.setInitialState('User A', 'token', [Role('User A', 'coach')]);
      when(presenter.appState).thenReturn(appState);

      final form = RegisterForm(screenHeight: 600, screenWidth: 400, presenter: presenter, coaches: const ['User A', 'User B', 'User C'],);

      final titleFinder = find.text('Register User');
      final locationFinder = find.byIcon(Icons.location_pin);
      final dateFinder = find.byIcon(Icons.date_range);

      await tester.pumpWidget(MaterialApp(
          title: 'Flutter Demo', home: Scaffold(backgroundColor: Helper.lightBlueColor, body: Center(child: form,))));

      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // enter country
      final austriaFinder = find.text('Austria');
      await tester.tap(locationFinder);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 2));
      await tester.tap(austriaFinder);
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      //enter date
      final buttonFinder = find.text('OK');
      final dateTextFinder = find.text('10');
      await tester.tap(dateFinder);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 2));
      await tester.tap(dateTextFinder);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 2));
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 2));

      form.enterData('User Name', 'user@email.com', 'MyPassword1234', '0888555555');

      expect(form.getCoachEmail(), 'User A');

      String month = DateTime.now().month.toString();
      String year = DateTime.now().year.toString();
      if(DateTime.now().month < 10) {
        month = '0$month';
      }
      expect(form.getDateOfBirth(), '10/$month/$year');

      expect(form.getPhoneNumber(), '0888555555');

      expect(form.getNationality(), 'Austria');

      expect(form.getName(), 'User Name');

      expect(form.getPassword(), 'MyPassword1234');

      expect(form.getEmail(), 'user@email.com');

      await tester.tap(titleFinder);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 2));

      verify(presenter.registerUser()).called(1);

      form.clearEmail();
      expect(form.getEmail(), '');

      form.clearPassword();
      expect(form.getPassword(), '');

      form.clearForm();
      expect(form.getPhoneNumber(), '');
    });
  });
}
