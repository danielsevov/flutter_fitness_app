import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/data/exceptions/fetch_failed_exception.dart';
import 'package:lift_to_live_flutter/domain/entities/exercise.dart';
import 'package:lift_to_live_flutter/domain/entities/role.dart';
import 'package:lift_to_live_flutter/domain/repositories/exercise_repo.dart';
import 'package:lift_to_live_flutter/domain/repositories/workout_repo.dart';
import 'package:lift_to_live_flutter/presentation/presenters/workout_templates_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/state_management/app_state.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/template_workout_holder.dart';
import 'package:lift_to_live_flutter/presentation/views/workout_templates_page_view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../mock_data.dart';
import 'workout_templates_page_presenter_test.mocks.dart';




@GenerateMocks([WorkoutRepository, ExerciseRepository, WorkoutTemplatesPageView])
void main() {
  test('test presenter constructor', () {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutTemplatesPagePresenter();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.userId = 'A';

    expect(presenter, isA<WorkoutTemplatesPagePresenter>());
    expect(presenter.isInitialized(), false);
  });

  test('test set app state', () {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutTemplatesPagePresenter();

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
    final presenter = WorkoutTemplatesPagePresenter();

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
    final presenter = WorkoutTemplatesPagePresenter();

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
    final presenter = WorkoutTemplatesPagePresenter();

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
    final presenter = WorkoutTemplatesPagePresenter();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.userId = 'A';

    expect(presenter.workouts, []);
  });

  test('test change user', () {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutTemplatesPagePresenter();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.userId = 'A';

    presenter.changeUser('B');
    expect(presenter.userId, 'B');
  });

  test('test fetchData() fail', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutTemplatesPagePresenter();
    final view = MockWorkoutTemplatesPageView();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.userId = 'A';

    presenter.detach();
    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    await presenter.fetchData();

    verify(view.notifyNoTemplateWorkoutsFound()).called(1);
  });

  test('test fetchData() fail fetch exercises', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutTemplatesPagePresenter();
    final view = MockWorkoutTemplatesPageView();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.userId = 'A';

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenThrow(FailedFetchException(''));

    await presenter.fetchData();

    verify(view.notifyNoTemplateWorkoutsFound()).called(1);
  });

  test('test fetchData() fail fetch workouts', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutTemplatesPagePresenter();
    final view = MockWorkoutTemplatesPageView();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.userId = 'A';

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchTemplates(any, any)).thenThrow(FailedFetchException(''));

    await presenter.fetchData();

    verify(view.notifyNoTemplateWorkoutsFound()).called(1);
  });

  test('test fetchData() fail empty workouts', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutTemplatesPagePresenter();
    final view = MockWorkoutTemplatesPageView();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.userId = 'A';

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchTemplates(any, any)).thenAnswer((realInvocation) async => []);

    List<Widget> list = [];

    when(view.setWorkoutData(any)).thenAnswer((realInvocation) {
      list = realInvocation.positionalArguments[0];
    });

    await presenter.fetchData();

    verifyNever(view.notifyNoTemplateWorkoutsFound());
    expect(list.length, 1);
  });

  test('test fetchData() success', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutTemplatesPagePresenter();
    final view = MockWorkoutTemplatesPageView();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.userId = 'A';

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchTemplates(any, any)).thenAnswer((realInvocation) async => [MockData.testWorkoutTemplate1, MockData.testWorkoutTemplate2]);

    List<Widget> list = [];

    when(view.setWorkoutData(any)).thenAnswer((realInvocation) {
      list = realInvocation.positionalArguments[0];
    });

    await presenter.fetchData();

    verifyNever(view.notifyNoTemplateWorkoutsFound());
    expect(list.length, 3);

    var element0 = list[0] as TemplateWorkoutHolder;
    var element1 = list[1] as TemplateWorkoutHolder;

    expect(element0.name, MockData.testWorkoutTemplate2.name);
    expect(element1.name, MockData.testWorkoutTemplate1.name);

    expect(element0.creationDate, MockData.testWorkoutTemplate2.createdOn);
    expect(element1.creationDate, MockData.testWorkoutTemplate1.createdOn);
  });

  test('test copyTemplate()', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutTemplatesPagePresenter();
    final view = MockWorkoutTemplatesPageView();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.userId = 'A';

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchTemplates(any, any)).thenAnswer((realInvocation) async => [MockData.testWorkoutTemplate1, MockData.testWorkoutTemplate2]);

    await presenter.fetchData();

    await presenter.copyWorkout(1);

    verify(view.notifyNewTemplate()).called(1);
  });
}
