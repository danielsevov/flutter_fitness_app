import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/data/exceptions/fetch_failed_exception.dart';
import 'package:lift_to_live_flutter/domain/entities/habit.dart';
import 'package:lift_to_live_flutter/domain/entities/habit_task.dart';
import 'package:lift_to_live_flutter/domain/entities/role.dart';
import 'package:lift_to_live_flutter/domain/repositories/habits_repo.dart';
import 'package:lift_to_live_flutter/presentation/presenters/habits_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/state_management/app_state.dart';
import 'package:lift_to_live_flutter/presentation/views/habits_page_view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'habit_page_presenter_test.mocks.dart';



@GenerateMocks([HabitsRepository, HabitsPageView])
void main() {
  test('test presenter constructor', () {
    final habitsRepo = MockHabitsRepository();
    final presenter = HabitsPagePresenter(habitsRepo, 'A');

    expect(presenter, isA<HabitsPagePresenter>());
    expect(presenter.isInitialized(), false);
  });

  test('test set app state', () {
    final habitsRepo = MockHabitsRepository();
    final presenter = HabitsPagePresenter(habitsRepo, 'A');
    final appState = AppState();
    expect(presenter.isInitialized(), false);

    expect(() async => presenter.setAppState(appState), returnsNormally);

    expect(presenter.isInitialized(), true);
  });

  test('test isAuthorized()', () {
    final habitsRepo = MockHabitsRepository();
    final presenter = HabitsPagePresenter(habitsRepo, 'A');
    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    expect(presenter.isAuthorized(), true);
  });

  test('test habits getter', () {
    final habitsRepo = MockHabitsRepository();
    final presenter = HabitsPagePresenter(habitsRepo, 'A');

    expect(presenter.habits, []);
  });

  test('test updateHabitEntry()', () {
    final habitsRepo = MockHabitsRepository();
    final presenter = HabitsPagePresenter(habitsRepo, 'A');
    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);
    presenter.updateHabitEntry(1, '', '', 'A', '', []);

    verify(habitsRepo.patchHabit(1, '', '', 'A', '', [], 'token')).called(1);
  });

  test('test fetch template fail', () async {
    final habitsRepo = MockHabitsRepository();
    when(habitsRepo.fetchTemplate(any, any)).thenThrow(FetchFailedException(''));

    final presenter = HabitsPagePresenter(habitsRepo, 'A');
    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    final view = MockHabitsPageView();
    presenter.attach(view);

    presenter.setAppState(appState);
    await presenter.fetchData();

    verify(view.notifyNoHabitsFound()).called(1);

    presenter.detach();
  });

  test('test fetch template empty', () async {
    final habitsRepo = MockHabitsRepository();
    when(habitsRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => Habit(0, '', '', '', '', true, [HabitTask('My Task 1', false)]));

    final presenter = HabitsPagePresenter(habitsRepo, 'A');
    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    final view = MockHabitsPageView();
    presenter.attach(view);
    presenter.detach();
    presenter.attach(view);

    presenter.setAppState(appState);
    await presenter.fetchData();

    verify(habitsRepo.postHabit(any, any, any, any, true, any, any)).called(1);
  });

  test('test fetch habits fail', () async {
    final habitsRepo = MockHabitsRepository();
    when(habitsRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => Habit(1, '', '', '', '', true, [HabitTask('My Task 1', false)]));
    when(habitsRepo.fetchHabits(any, any)).thenThrow(FetchFailedException(''));

    final presenter = HabitsPagePresenter(habitsRepo, 'A');
    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    final view = MockHabitsPageView();
    presenter.attach(view);

    presenter.setAppState(appState);
    await presenter.fetchData();

    verify(view.notifyNoHabitsFound()).called(1);
  });

  test('test fetch habits empty', () async {
    final habitsRepo = MockHabitsRepository();
    when(habitsRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => Habit(1, '', '', '', '', true, [HabitTask('My Task 1', false)]));
    when(habitsRepo.fetchHabits(any, any)).thenAnswer((realInvocation) async => []);

    final presenter = HabitsPagePresenter(habitsRepo, 'A');
    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    final view = MockHabitsPageView();
    presenter.attach(view);

    presenter.setAppState(appState);
    await presenter.fetchData();

    verify(habitsRepo.postHabit(any, any, any, any, false, any, any)).called(1);
  });

  test('test fetch data success', () async {
    final habitsRepo = MockHabitsRepository();
    when(habitsRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => Habit(1, '', '', '', '', true, [HabitTask('My Task 1', false)]));
    when(habitsRepo.fetchHabits(any, any)).thenAnswer((realInvocation) async => [Habit(1, '', '', '', '', false, [HabitTask('My Task 1', false)]), Habit(2, '', '', '', '', false, [HabitTask('My Task 1', false)])]);

    final presenter = HabitsPagePresenter(habitsRepo, 'A');
    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    final view = MockHabitsPageView();
    presenter.attach(view);

    presenter.setAppState(appState);
    await presenter.fetchData();

    expect(presenter.habits.length, 2);
    verify(view.setHabitData(any)).called(1);
  });
}
