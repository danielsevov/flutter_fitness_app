import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/data/exceptions/fetch_failed_exception.dart';
import 'package:lift_to_live_flutter/domain/entities/role.dart';
import 'package:lift_to_live_flutter/domain/repositories/token_repo.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:lift_to_live_flutter/presentation/presenters/log_in_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/state_management/app_state.dart';
import 'package:lift_to_live_flutter/presentation/views/log_in_form_view.dart';
import 'package:lift_to_live_flutter/presentation/views/log_in_page_view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'log_in_presenter_test.mocks.dart';


@GenerateMocks([TokenRepository, UserRepository, LogInPageView, LogInFormView])
void main() {
  test('test presenter constructor', () {
    final tokenRepo = MockTokenRepository();
    final userRepo = MockUserRepository();
    final presenter = LogInPagePresenter(tokenRepo, userRepo);

    expect(presenter, isA<LogInPagePresenter>());
    expect(presenter.isInitialized(), false);
  });

  group('test attach and detach view methods', () {
    test('test attach view', () {
      final tokenRepo = MockTokenRepository();
      final userRepo = MockUserRepository();
      final view = MockLogInPageView();
      final presenter = LogInPagePresenter(tokenRepo, userRepo);

      expect(() async => presenter.attach(view), returnsNormally);
    });

    test('test detach view', () {
      final tokenRepo = MockTokenRepository();
      final userRepo = MockUserRepository();
      final presenter = LogInPagePresenter(tokenRepo, userRepo);

      expect(() async => presenter.detach(), returnsNormally);
    });

    test('test attach and detach view', () {
      final tokenRepo = MockTokenRepository();
      final userRepo = MockUserRepository();
      final view = MockLogInPageView();
      final presenter = LogInPagePresenter(tokenRepo, userRepo);

      expect(() async => presenter..attach(view)..detach(), returnsNormally);
    });
  });

  test('test set app state', () {
    final tokenRepo = MockTokenRepository();
    final userRepo = MockUserRepository();
    final appState = AppState();
    final presenter = LogInPagePresenter(tokenRepo, userRepo);
    expect(presenter.isInitialized(), false);

    expect(() async => presenter.setAppState(appState), returnsNormally);

    expect(presenter.isInitialized(), true);
  });

  group('test log in  method', () {
    test('successful log in test', () async {
      final tokenRepo = MockTokenRepository();
      final userRepo = MockUserRepository();
      final view = MockLogInPageView();
      final appState = AppState();
      final presenter = LogInPagePresenter(tokenRepo, userRepo);
      final form = MockLogInFormView();

      presenter.setAppState(appState);
      presenter.attach(view);

      when(view.setInProgress(any)).thenAnswer((realInvocation) { });
      when(view.navigateToHome()).thenAnswer((realInvocation) { });
      when(view.notifyWrongCredentials()).thenAnswer((realInvocation) { });
      when(view.getLogInForm()).thenReturn(form);
      when(form.getEmail()).thenReturn('email@email.com');
      when(form.getPassword()).thenReturn('password');
      when(form.clearPassword()).thenAnswer((realInvocation) { });
      when(form.clearForm()).thenAnswer((realInvocation) { });
      when(tokenRepo.getToken('email@email.com', 'password')).thenAnswer(
              (_) async => 'token_success');
      when(userRepo.fetchUserRoles('token_success')).thenAnswer(
              (_) async => [Role('A', 'A'), Role('B', 'B')]);

      await presenter.logIn();

      expect(appState.getToken(), 'token_success');
      expect(appState.getUserRoles().length, 2);
      verify(view.setInProgress(true)).called(1);
      verify(tokenRepo.getToken('email@email.com', 'password')).called(1);
      verify(userRepo.fetchUserRoles('token_success')).called(1);
      verify(view.navigateToHome()).called(1);
      verify(view.setInProgress(false)).called(1);
    });

    test('failed log in test', () async {
      final tokenRepo = MockTokenRepository();
      final userRepo = MockUserRepository();
      final view = MockLogInPageView();
      final appState = AppState();
      final presenter = LogInPagePresenter(tokenRepo, userRepo);
      final form = MockLogInFormView();

      presenter.setAppState(appState);
      presenter.attach(view);

      when(view.setInProgress(any)).thenAnswer((realInvocation) { });
      when(view.navigateToHome()).thenAnswer((realInvocation) { });
      when(view.notifyWrongCredentials()).thenAnswer((realInvocation) { });
      when(view.getLogInForm()).thenReturn(form);
      when(form.getEmail()).thenReturn('email@email.com');
      when(form.getPassword()).thenReturn('wrong_password');
      when(form.clearPassword()).thenAnswer((realInvocation) { });
      when(form.clearForm()).thenAnswer((realInvocation) { });
      when(tokenRepo.getToken('email@email.com', 'wrong_password')).thenAnswer(
              (_) async => '');

      await presenter.logIn();

      expect(appState.getToken(), '');
      expect(appState.getUserRoles().length, 0);
      verify(view.setInProgress(true)).called(1);
      verify(tokenRepo.getToken('email@email.com', 'wrong_password')).called(1);
      verifyNever(userRepo.fetchUserRoles(''));
      verify(view.notifyWrongCredentials()).called(1);
      verify(view.setInProgress(false)).called(1);
    });

    test('exception thrown log in test', () async {
      final tokenRepo = MockTokenRepository();
      final userRepo = MockUserRepository();
      final view = MockLogInPageView();
      final appState = AppState();
      final presenter = LogInPagePresenter(tokenRepo, userRepo);
      final form = MockLogInFormView();

      presenter.setAppState(appState);
      presenter.attach(view);

      when(view.setInProgress(any)).thenAnswer((realInvocation) { });
      when(view.navigateToHome()).thenAnswer((realInvocation) { });
      when(view.notifyWrongCredentials()).thenAnswer((realInvocation) { });
      when(view.getLogInForm()).thenReturn(form);
      when(form.getEmail()).thenReturn('email@email.com');
      when(form.getPassword()).thenReturn('wrong_password');
      when(form.clearPassword()).thenAnswer((realInvocation) { });
      when(form.clearForm()).thenAnswer((realInvocation) { });
      when(tokenRepo.getToken('email@email.com', 'wrong_password')).thenThrow(FetchFailedException('no token'));

      await presenter.logIn();

      expect(appState.getToken(), '');
      expect(appState.getUserRoles().length, 0);
      verify(view.setInProgress(true)).called(1);
      verify(tokenRepo.getToken('email@email.com', 'wrong_password')).called(1);
      verifyNever(userRepo.fetchUserRoles(''));
      verify(view.notifyWrongCredentials()).called(1);
      verify(view.setInProgress(false)).called(1);
    });
  });
}
