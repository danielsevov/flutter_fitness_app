import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/data/exceptions/fetch_failed_exception.dart';
import 'package:lift_to_live_flutter/domain/entities/role.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:lift_to_live_flutter/presentation/presenters/trainees_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/state_management/app_state.dart';
import 'package:lift_to_live_flutter/presentation/views/trainees_page_view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../mock_data.dart';
import '../widget_tests/trainee_widget_test.mocks.dart';
import 'profile_page_presenter_test.mocks.dart';


@GenerateMocks([UserRepository, TraineesPageView])
void main() {
  test('test presenter constructor', () {
    final userRepo = MockUserRepository();
    final presenter = TraineesPagePresenter();
    presenter.attachRepositories(userRepo);
    final view = MockTraineesPageView();
    presenter.attach(view);
    presenter.detach();

    expect(presenter, isA<TraineesPagePresenter>());
    expect(presenter.isInitialized(), false);
  });

  test('test set app state', () {
    final userRepo = MockUserRepository();
    final appState = AppState();
    final presenter = TraineesPagePresenter();
    presenter.attachRepositories(userRepo);
    expect(presenter.isInitialized(), false);

    expect(() async => presenter.setAppState(appState), returnsNormally);

    expect(presenter.isInitialized(), true);
  });

  test('test set app state', () {
    final userRepo = MockUserRepository();
    final appState = AppState();
    final presenter = TraineesPagePresenter();
    presenter.attachRepositories(userRepo);
    expect(presenter.isInitialized(), false);

    appState.setInitialState('email@email.com', '', []);
    presenter.setAppState(appState);


    expect(presenter.isAuthorized(), false);
  });

  test('test set app state 2', () {
    final userRepo = MockUserRepository();
    final appState = AppState();
    final presenter = TraineesPagePresenter();
    presenter.attachRepositories(userRepo);
    expect(presenter.isInitialized(), false);

    appState.setInitialState('email@email.com', '', [Role('email@email.com', 'admin')]);
    presenter.setAppState(appState);


    expect(presenter.isAuthorized(), true);
  });

  test('test fetch data', () async {
    final userRepo = MockUserRepository();
    final appState = AppState();
    final presenter = TraineesPagePresenter();
    presenter.attachRepositories(userRepo);
    final view = MockTraineesPageView();
    presenter.attach(view);

    expect(presenter.isInitialized(), false);

    when(userRepo.fetchMyTrainees(any, any)).thenAnswer((realInvocation) async => [MockData.testUser1]);
    when(userRepo.fetchProfileImage(any, any)).thenAnswer((realInvocation) async => MockData.testImage3);

    appState.setInitialState('email@email.com', '', []);
    presenter.setAppState(appState);

    await presenter.fetchData();

    expect(() async => await presenter.fetchData(), returnsNormally);
  });

  test('test fetch data 2', () {
    final userRepo = MockUserRepository();
    final appState = AppState();
    final presenter = TraineesPagePresenter();
    presenter.attachRepositories(userRepo);
    final view = MockTraineesPageView();
    presenter.attach(view);

    expect(presenter.isInitialized(), false);

    when(userRepo.fetchMyTrainees(any, any)).thenThrow(FailedFetchException('fail'));
    when(userRepo.fetchProfileImage(any, any)).thenAnswer((realInvocation) async => MockData.testImage3);

    appState.setInitialState('email@email.com', '', []);
    presenter.setAppState(appState);

    expect(() async => await presenter.fetchData(), returnsNormally);
  });

  test('test fetch data 3', () {
    final userRepo = MockUserRepository();
    final appState = AppState();
    final presenter = TraineesPagePresenter();
    presenter.attachRepositories(userRepo);
    final view = MockTraineesPageView();
    presenter.attach(view);

    expect(presenter.isInitialized(), false);

    when(userRepo.fetchMyTrainees(any, any)).thenAnswer((realInvocation) async => [MockData.testUser1]);
    when(userRepo.fetchProfileImage(any, any)).thenThrow(FailedFetchException('fail'));

    appState.setInitialState('email@email.com', '', []);
    presenter.setAppState(appState);

    expect(() async => await presenter.fetchData(), returnsNormally);
  });
}
