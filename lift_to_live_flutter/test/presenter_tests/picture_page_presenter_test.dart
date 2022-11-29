import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/data/exceptions/fetch_failed_exception.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:lift_to_live_flutter/presentation/presenters/picture_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/state_management/app_state.dart';
import 'package:lift_to_live_flutter/presentation/views/picture_page_view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_data.dart';
import 'picture_page_presenter_test.mocks.dart';


@GenerateMocks([UserRepository, PicturePageView])
void main() {
  test('test presenter constructor', () {
    final userRepo = MockUserRepository();
    final presenter = PicturePagePresenter(userRepo, 'email@email.com');
    final view = MockPicturePageView();
    presenter.attach(view);
    presenter.detach();

    expect(presenter, isA<PicturePagePresenter>());
    expect(presenter.isInitialized(), false);
  });

  test('test set app state', () {
    final userRepo = MockUserRepository();
    final appState = AppState();
    final presenter = PicturePagePresenter(userRepo, 'email@email.com');
    expect(presenter.isInitialized(), false);

    expect(() async => presenter.setAppState(appState), returnsNormally);

    expect(presenter.isInitialized(), true);
  });

  test('test set app state', () {
    final userRepo = MockUserRepository();
    final appState = AppState();
    final presenter = PicturePagePresenter(userRepo, 'email@email.com');
    expect(presenter.isInitialized(), false);

    appState.setInitialState('email@email.com', '', []);
    presenter.setAppState(appState);

    expect(presenter.isAuthorized(), true);
  });

  test('test fetch data', () {
    final userRepo = MockUserRepository();
    final appState = AppState();
    final presenter = PicturePagePresenter(userRepo, 'email@email.com');
    expect(presenter.isInitialized(), false);

    when(userRepo.getUserImages(any, any)).thenAnswer((realInvocation) async => [TestData.test_image_1, TestData.test_image_2]);

    appState.setInitialState('email@email.com', '', []);
    presenter.setAppState(appState);

    expect(() => presenter.fetchData(), returnsNormally);
  });

  test('test fetch data failed', () {
    final userRepo = MockUserRepository();
    final appState = AppState();
    final presenter = PicturePagePresenter(userRepo, 'email@email.com');
    expect(presenter.isInitialized(), false);

    when(userRepo.getUserImages(any, any)).thenThrow(FetchFailedException('fail'));

    appState.setInitialState('email@email.com', '', []);
    presenter.setAppState(appState);

    expect(() => presenter.fetchData(), returnsNormally);
  });

  test('test fetch data failed', () {
    final userRepo = MockUserRepository();
    final appState = AppState();
    final presenter = PicturePagePresenter(userRepo, 'email@email.com');
    expect(presenter.isInitialized(), false);

    when(userRepo.getUserImages(any, any)).thenAnswer((realInvocation) async => [TestData.test_image_1, TestData.test_image_2]);
    when(userRepo.deleteImage(any, any)).thenAnswer((realInvocation) async => {});

    appState.setInitialState('email@email.com', 'token', []);
    presenter.setAppState(appState);

    expect(() => presenter.fetchData(), returnsNormally);

    expect(() => presenter.deleteImage(1), returnsNormally);

    expect(() => presenter.fetchData(), returnsNormally);

    verify(userRepo.deleteImage(1, 'token'));
  });
}
