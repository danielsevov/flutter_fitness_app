import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/data/exceptions/fetch_failed_exception.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:lift_to_live_flutter/presentation/presenters/profile_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/state_management/app_state.dart';
import 'package:lift_to_live_flutter/presentation/views/profile_page_view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_data.dart';
import 'home_page_presenter_test.mocks.dart';


@GenerateMocks([UserRepository, ProfilePageView])
void main() {
  test('test presenter constructor', () {
    final userRepo = MockUserRepository();
    final presenter = ProfilePagePresenter(userRepo, 'email@email.com');

    expect(presenter, isA<ProfilePagePresenter>());
    expect(presenter.isInitialized(), false);
  });

  test('test set app state', () {
    final userRepo = MockUserRepository();
    final appState = AppState();
    final presenter = ProfilePagePresenter(userRepo, 'email@email.com');
    expect(presenter.isInitialized(), false);

    expect(() async => presenter.setAppState(appState), returnsNormally);

    expect(presenter.isInitialized(), true);
  });

  test('test set app state', () {
    final userRepo = MockUserRepository();
    final appState = AppState();
    final presenter = ProfilePagePresenter(userRepo, 'email@email.com');
    expect(presenter.isInitialized(), false);

    appState.setInitialState('email@email.com', '', []);
    presenter.setAppState(appState);


    expect(presenter.isAuthorized(), true);
  });

  test('test fetch data', () {
    final userRepo = MockUserRepository();
    final appState = AppState();
    final presenter = ProfilePagePresenter(userRepo, 'email@email.com');
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
    final presenter = ProfilePagePresenter(userRepo, 'email@email.com');
    expect(presenter.isInitialized(), false);

    when(userRepo.fetchUser(any, any)).thenThrow(FetchFailedException('fail'));
    when(userRepo.fetchProfileImage(any, any)).thenAnswer((realInvocation) async => TestData.test_image_1);

    appState.setInitialState('email@email.com', '', []);
    presenter.setAppState(appState);

    expect(() => presenter.fetchData(), returnsNormally);
  });

  test('test fetch data 3', () {
    final userRepo = MockUserRepository();
    final appState = AppState();
    final presenter = ProfilePagePresenter(userRepo, 'email@email.com');
    expect(presenter.isInitialized(), false);

    when(userRepo.fetchUser(any, any)).thenThrow(FetchFailedException('fail'));
    when(userRepo.fetchProfileImage(any, any)).thenThrow(FetchFailedException('fail'));

    appState.setInitialState('email@email.com', '', []);
    presenter.setAppState(appState);

    expect(() => presenter.fetchData(), returnsNormally);
  });
}
