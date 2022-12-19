import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/data/exceptions/fetch_failed_exception.dart';
import 'package:lift_to_live_flutter/domain/entities/role.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:lift_to_live_flutter/presentation/presenters/profile_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/state_management/app_state.dart';
import 'package:lift_to_live_flutter/presentation/views/profile_page_view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_data.dart';
import 'profile_page_presenter_test.mocks.dart';


@GenerateMocks([UserRepository, ProfilePageView])
void main() {
  test('test presenter constructor', () {
    final userRepo = MockUserRepository();
    final presenter = ProfilePagePresenter();
    presenter.attachRepositories(userRepo);
    presenter.userId = 'email@email.com';
    
    final view = MockProfilePageView();
    presenter.attach(view);
    presenter.detach();

    expect(presenter, isA<ProfilePagePresenter>());
    expect(presenter.isInitialized(), false);
  });

  test('test set app state', () {
    final userRepo = MockUserRepository();
    final appState = AppState();
    final presenter = ProfilePagePresenter();
    presenter.attachRepositories(userRepo);
    presenter.userId = 'email@email.com';
    expect(presenter.isInitialized(), false);

    expect(() async => presenter.setAppState(appState), returnsNormally);

    expect(presenter.isInitialized(), true);
  });

  test('test set app state', () {
    final userRepo = MockUserRepository();
    final appState = AppState();
    final presenter = ProfilePagePresenter();
    presenter.attachRepositories(userRepo);
    presenter.userId = 'email@email.com';
    expect(presenter.isInitialized(), false);

    appState.setInitialState('email@email.com', '', []);
    presenter.setAppState(appState);


    expect(presenter.isAuthorized(false), true);
  });

  test('test set app state', () {
    final userRepo = MockUserRepository();
    final appState = AppState();
    final presenter = ProfilePagePresenter();
    presenter.attachRepositories(userRepo);
    presenter.userId = 'email@email.com';
    presenter.reset();
    expect(presenter.isInitialized(), false);

    appState.setInitialState('email@email.com', '', [Role('emaill@email.com', 'admin')]);
    presenter.setAppState(appState);

    expect(presenter.isAuthorized(true), true);

    presenter.userId = 'email2@email.com';
    expect(presenter.isAuthorized(true), false);
  });

  test('test fetch data', () {
    final userRepo = MockUserRepository();
    final appState = AppState();
    final presenter = ProfilePagePresenter();
    presenter.attachRepositories(userRepo);
    presenter.userId = 'email@email.com';
    expect(presenter.isInitialized(), false);

    when(userRepo.fetchUser(any, any)).thenAnswer((realInvocation) async => TestData.test_user_1);
    when(userRepo.fetchProfileImage(any, any)).thenAnswer((realInvocation) async => TestData.test_image_1);

    appState.setInitialState('email@email.com', '', []);
    presenter.setAppState(appState);

    expect(() => presenter.fetchData(), returnsNormally);
  });

  test('test fetch data 2', () {
    final userRepo = MockUserRepository();
    final appState = AppState();
    final presenter = ProfilePagePresenter();
    presenter.attachRepositories(userRepo);
    presenter.userId = 'email@email.com';
    expect(presenter.isInitialized(), false);

    when(userRepo.fetchUser(any, any)).thenThrow(FailedFetchException('fail'));
    when(userRepo.fetchProfileImage(any, any)).thenAnswer((realInvocation) async => TestData.test_image_1);

    appState.setInitialState('email@email.com', '', []);
    presenter.setAppState(appState);

    expect(() => presenter.fetchData(), returnsNormally);
  });

  test('test fetch data 3', () {
    final userRepo = MockUserRepository();
    final appState = AppState();
    final presenter = ProfilePagePresenter();
    presenter.attachRepositories(userRepo);
    presenter.userId = 'email@email.com';
    expect(presenter.isInitialized(), false);

    when(userRepo.fetchUser(any, any)).thenAnswer((realInvocation) async => TestData.test_user_1);
    when(userRepo.fetchProfileImage(any, any)).thenThrow(FailedFetchException('fail'));

    appState.setInitialState('email@email.com', '', []);
    presenter.setAppState(appState);

    expect(() => presenter.fetchData(), returnsNormally);
  });
}
