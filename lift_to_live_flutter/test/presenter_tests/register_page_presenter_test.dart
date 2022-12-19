import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/data/exceptions/duplicated_id_exception.dart';
import 'package:lift_to_live_flutter/data/exceptions/fetch_failed_exception.dart';
import 'package:lift_to_live_flutter/domain/entities/role.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:lift_to_live_flutter/presentation/presenters/register_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/state_management/app_state.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/forms_and_dialogs/register_form.dart';
import 'package:lift_to_live_flutter/presentation/views/register_page_view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_page_presenter_test.mocks.dart';


@GenerateMocks([RegisterPageView, UserRepository])
void main() {
  test('test presenter constructor', () {
    final userRepo = MockUserRepository();
    final presenter = RegisterPagePresenter();
      presenter.attachRepositories(userRepo);

    expect(presenter, isA<RegisterPagePresenter>());
    expect(presenter.isInitialized(), false);
  });

  group('test attach and detach view methods', () {
    test('test attach view', () {
      final view = MockRegisterPageView();
      final userRepo = MockUserRepository();
      final presenter = RegisterPagePresenter();
      presenter.attachRepositories(userRepo);

      expect(() async => presenter.attach(view), returnsNormally);
    });

    test('test detach view', () {
      final userRepo = MockUserRepository();
      final presenter = RegisterPagePresenter();
      presenter.attachRepositories(userRepo);

      expect(() async => presenter.detach(), returnsNormally);
    });

    test('test attach and detach view', () {
      final view = MockRegisterPageView();
      final userRepo = MockUserRepository();
      final presenter = RegisterPagePresenter();
      presenter.attachRepositories(userRepo);

      expect(() async => presenter..attach(view)..detach(), returnsNormally);
    });
  });

  test('test set app state', () {
    final appState = AppState();
    final userRepo = MockUserRepository();
    final presenter = RegisterPagePresenter();
      presenter.attachRepositories(userRepo);
    expect(presenter.isInitialized(), false);

    expect(() async => presenter.setAppState(appState), returnsNormally);

    expect(presenter.isInitialized(), true);
  });

  test('test fetch data fail', () {
    final view = MockRegisterPageView();
    final userRepo = MockUserRepository();
    final presenter = RegisterPagePresenter();
      presenter.attachRepositories(userRepo);
    final appState = AppState();
    appState.setInitialState('email', 'token', [Role('email', 'admin')]);
    when(userRepo.fetchCoachRoles(any)).thenThrow(FailedFetchException(''));

    presenter.attach(view);
    presenter.setAppState(appState);

    expect(() => presenter.fetchData(), returnsNormally);
    verify(view.notifyRegisterFailed()).called(1);
  });

  test('test fetch data success', () async {
    final view = MockRegisterPageView();
    final userRepo = MockUserRepository();
    final presenter = RegisterPagePresenter();
      presenter.attachRepositories(userRepo);
    final appState = AppState();
    appState.setInitialState('email', 'token', [Role('email', 'admin')]);
    when(userRepo.fetchCoachRoles(any)).thenAnswer((realInvocation) async => [Role('email1', 'coach')]);

    presenter.attach(view);
    presenter.setAppState(appState);

    await presenter.fetchData();

    expect(() async => await presenter.fetchData(), returnsNormally);
    verify(view.setCoachData(['email1', 'email'])).called(1);
  });

  test('test register user fail', () async {
    final view = MockRegisterPageView();
    final userRepo = MockUserRepository();
    final presenter = RegisterPagePresenter();
      presenter.attachRepositories(userRepo);
    final appState = AppState();
    appState.setInitialState('email', 'token', [Role('email', 'admin')]);
    when(userRepo.fetchCoachRoles(any)).thenAnswer((realInvocation) async => [Role('email1', 'coach')]);
    when(view.getRegisterForm()).thenReturn(RegisterForm(screenHeight: 400, screenWidth: 400, presenter: presenter, coaches: const ['email']));
    when(userRepo.registerUser(any, any, any, any, any, any, any, any)).thenThrow(FailedFetchException(''));

    presenter.attach(view);
    presenter.setAppState(appState);

    await presenter.fetchData();
    await presenter.registerUser();

    expect(() async => await presenter.fetchData(), returnsNormally);
    verify(view.notifyRegisterFailed()).called(1);
  });

  test('test register user fail duplicate', () async {
    final view = MockRegisterPageView();
    final userRepo = MockUserRepository();
    final presenter = RegisterPagePresenter();
      presenter.attachRepositories(userRepo);
    final appState = AppState();
    appState.setInitialState('email', 'token', [Role('email', 'admin')]);
    when(userRepo.fetchCoachRoles(any)).thenAnswer((realInvocation) async => [Role('email1', 'coach')]);
    when(view.getRegisterForm()).thenReturn(RegisterForm(screenHeight: 400, screenWidth: 400, presenter: presenter, coaches: const ['email']));
    when(userRepo.registerUser(any, any, any, any, any, any, any, any)).thenThrow(DuplicatedIdException(''));

    presenter.attach(view);
    presenter.setAppState(appState);

    await presenter.fetchData();
    await presenter.registerUser();

    verify(view.notifyEmailAlreadyExists()).called(1);
  });

  test('test register user success', () async {
    final view = MockRegisterPageView();
    final userRepo = MockUserRepository();
    final presenter = RegisterPagePresenter();
      presenter.attachRepositories(userRepo);
    final appState = AppState();
    appState.setInitialState('email', 'token', [Role('email', 'admin')]);
    when(userRepo.fetchCoachRoles(any)).thenAnswer((realInvocation) async => [Role('email1', 'coach')]);
    when(view.getRegisterForm()).thenReturn(RegisterForm(screenHeight: 400, screenWidth: 400, presenter: presenter, coaches: const ['email']));

    presenter.attach(view);
    presenter.setAppState(appState);

    await presenter.fetchData();
    await presenter.registerUser();

    verify(view.notifyUserRegistered()).called(1);
  });
}
