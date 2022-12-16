import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/data/exceptions/fetch_failed_exception.dart';
import 'package:lift_to_live_flutter/domain/entities/habit.dart';
import 'package:lift_to_live_flutter/domain/entities/habit_task.dart';
import 'package:lift_to_live_flutter/domain/entities/role.dart';
import 'package:lift_to_live_flutter/domain/repositories/habits_repo.dart';
import 'package:lift_to_live_flutter/presentation/presenters/edit_habits_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/state_management/app_state.dart';
import 'package:lift_to_live_flutter/presentation/views/edit_habits_page_view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_habits_page_presenter_test.mocks.dart';

@GenerateMocks([HabitsRepository, EditHabitsPageView])
void main() {
  test('test presenter constructor', () {
    final habitsRepo = MockHabitsRepository();
    final presenter = EditHabitsPagePresenter(habitsRepo, 'A');

    expect(presenter, isA<EditHabitsPagePresenter>());
    expect(presenter.isInitialized(), false);
  });

  test('test set app state', () {
    final habitsRepo = MockHabitsRepository();
    final presenter = EditHabitsPagePresenter(habitsRepo, 'A');
    final appState = AppState();
    expect(presenter.isInitialized(), false);

    expect(() async => presenter.setAppState(appState), returnsNormally);

    expect(presenter.isInitialized(), true);
  });

  test('test isAuthorized()', () {
    final habitsRepo = MockHabitsRepository();
    final presenter = EditHabitsPagePresenter(habitsRepo, 'A');
    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    expect(presenter.isAuthorized(), true);
  });

  test('test addNewElement()', () {
    final habitsRepo = MockHabitsRepository();
    final presenter = EditHabitsPagePresenter(habitsRepo, 'A');
    final view = MockEditHabitsPageView();
    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);
    presenter.setAppState(appState);
    presenter.detach();
    presenter.attach(view);

    presenter.addNewElement();

    verify(view.addTaskElement('Enter task here', any)).called(1);
  });

  test('test fetchData fail()', () {
    final habitsRepo = MockHabitsRepository();
    final presenter = EditHabitsPagePresenter(habitsRepo, 'A');
    final view = MockEditHabitsPageView();
    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);
    presenter.setAppState(appState);
    presenter.detach();
    presenter.attach(view);

    when(habitsRepo.fetchTemplate(any, any)).thenThrow(FailedFetchException(''));

    expect(() => {presenter.fetchData()}, returnsNormally);
    verifyNever(view.setFetched(true));
  });

  test('test fetchData success()', () async {
    final habitsRepo = MockHabitsRepository();
    final presenter = EditHabitsPagePresenter(habitsRepo, 'A');
    final view = MockEditHabitsPageView();
    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);
    presenter.setAppState(appState);
    presenter.detach();
    presenter.attach(view);

    when(habitsRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => Habit(0, '', '', '', '', true, [HabitTask('My Task 1', false)]));

    await presenter.fetchData();

    verify(view.addTaskElement(any, any)).called(1);
    verify(view.setFetched(true)).called(1);
  });

  test('test saveChanges()', () async {
    final habitsRepo = MockHabitsRepository();
    final presenter = EditHabitsPagePresenter(habitsRepo, 'A');
    final view = MockEditHabitsPageView();
    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);
    presenter.setAppState(appState);
    presenter.detach();
    presenter.attach(view);

    when(habitsRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => Habit(0, '', '', '', '', true, [HabitTask('My Task 1', false)]));

    await presenter.fetchData();

    final cn1 = TextEditingController();
    cn1.text = 'Not empty';

    when(view.getControllers()).thenReturn([cn1]);

    presenter.saveChanges();

    verify(view.notifySavedChanges()).called(1);
    verify(habitsRepo.patchHabit(any, any, any, any, any, any, any)).called(1);
  });
}
