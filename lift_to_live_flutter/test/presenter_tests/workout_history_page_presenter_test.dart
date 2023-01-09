import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/data/exceptions/fetch_failed_exception.dart';
import 'package:lift_to_live_flutter/domain/entities/exercise.dart';
import 'package:lift_to_live_flutter/domain/entities/role.dart';
import 'package:lift_to_live_flutter/domain/repositories/exercise_repo.dart';
import 'package:lift_to_live_flutter/domain/repositories/workout_repo.dart';
import 'package:lift_to_live_flutter/presentation/presenters/workout_history_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/state_management/app_state.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/workout_holder.dart';
import 'package:lift_to_live_flutter/presentation/views/workout_history_page_view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_data.dart';
import 'workout_history_page_presenter_test.mocks.dart';




@GenerateMocks([WorkoutRepository, ExerciseRepository, WorkoutHistoryPageView])
void main() {
  test('test presenter constructor', () {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutHistoryPagePresenter();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.userId = 'A';

    expect(presenter, isA<WorkoutHistoryPagePresenter>());
    expect(presenter.isInitialized(), false);
  });

  test('test set app state', () {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutHistoryPagePresenter();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.userId = 'A';

    final appState = AppState();
    expect(presenter.isInitialized(), false);

    expect(() async => presenter.setAppState(appState), returnsNormally);

    expect(presenter.isInitialized(), true);
  });

  test('test isAuthorized()', () {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutHistoryPagePresenter();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.userId = 'A';

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    expect(presenter.isAuthorized(), true);
  });

  test('test isOwner()', () {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutHistoryPagePresenter();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.userId = 'A';

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    expect(presenter.isOwner(), true);
  });

  test('test fail isOwner()', () {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutHistoryPagePresenter();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.userId = 'A';

    final appState = AppState();
    appState.setInitialState('B', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    expect(presenter.isOwner(), false);
  });

  test('test workouts getter', () {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutHistoryPagePresenter();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.userId = 'A';

    expect(presenter.workouts, []);
  });

  test('test change user', () {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutHistoryPagePresenter();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.userId = 'A';

    presenter.changeUser('B');
    expect(presenter.userId, 'B');
  });

  test('test fetchData() fail', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutHistoryPagePresenter();
    final view = MockWorkoutHistoryPageView();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.userId = 'A';

    presenter.detach();
    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    await presenter.fetchData();

    verify(view.notifyNoWorkoutsFound()).called(1);
  });

  test('test fetchData() fail fetch exercises', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutHistoryPagePresenter();
    final view = MockWorkoutHistoryPageView();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.userId = 'A';

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenThrow(FailedFetchException(''));

    await presenter.fetchData();

    verify(view.notifyNoWorkoutsFound()).called(1);
  });

  test('test fetchData() fail fetch workouts', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutHistoryPagePresenter();
    final view = MockWorkoutHistoryPageView();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.userId = 'A';

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkouts(any, any)).thenThrow(FailedFetchException(''));

    await presenter.fetchData();

    verify(view.notifyNoWorkoutsFound()).called(1);
  });

  test('test fetchData() success empty workouts', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutHistoryPagePresenter();
    final view = MockWorkoutHistoryPageView();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.userId = 'A';

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkouts(any, any)).thenAnswer((realInvocation) async => []);

    List<Widget> list = [];
    List<String> dates = [];

    when(view.setWorkoutData(any, any)).thenAnswer((realInvocation) {
      list = realInvocation.positionalArguments[0];
      dates = realInvocation.positionalArguments[1];
    });

    await presenter.fetchData();

    verifyNever(view.notifyNoWorkoutsFound());
    expect(list.length, 1);
    expect(dates.length, 0);
  });

  test('test fetchData() success', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutHistoryPagePresenter();
    final view = MockWorkoutHistoryPageView();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.userId = 'A';

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkouts(any, any)).thenAnswer((realInvocation) async => [TestData.testWorkout1, TestData.testWorkout2]);

    List<Widget> list = [];
    List<String> dates = [];

    when(view.setWorkoutData(any, any)).thenAnswer((realInvocation) {
      list = realInvocation.positionalArguments[0];
      dates = realInvocation.positionalArguments[1];
    });

    await presenter.fetchData();

    verifyNever(view.notifyNoWorkoutsFound());
    expect(list.length, 3);
    expect(dates.length, 2);

    var element0 = list[0] as WorkoutHolder;
    var element1 = list[1] as WorkoutHolder;

    expect(element0.name, TestData.testWorkout2.name);
    expect(element1.name, TestData.testWorkout1.name);

    expect(element0.created, TestData.testWorkout2.createdOn);
    expect(element1.created, TestData.testWorkout1.createdOn);
  });
}
