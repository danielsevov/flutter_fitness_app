import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/data/exceptions/fetch_failed_exception.dart';
import 'package:lift_to_live_flutter/domain/entities/exercise.dart';
import 'package:lift_to_live_flutter/domain/entities/role.dart';
import 'package:lift_to_live_flutter/domain/entities/workout.dart';
import 'package:lift_to_live_flutter/domain/repositories/exercise_repo.dart';
import 'package:lift_to_live_flutter/domain/repositories/workout_repo.dart';
import 'package:lift_to_live_flutter/presentation/presenters/workout_page_presenter.dart';
import 'package:lift_to_live_flutter/presentation/state_management/app_state.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/editable_set_holder.dart';
import 'package:lift_to_live_flutter/presentation/views/workout_page_view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../mock_data.dart';
import 'workout_page_presenter_test.mocks.dart';




@GenerateMocks([WorkoutRepository, ExerciseRepository, WorkoutPageView])
void main() {
  test('test presenter constructor', () {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(1, 'A', false, false);

    expect(presenter, isA<WorkoutPagePresenter>());
    expect(presenter.isInitialized(), false);
  });

  test('test set app state', () {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(1, 'A', false, false);

    final appState = AppState();
    expect(presenter.isInitialized(), false);

    expect(() async => presenter.setAppState(appState), returnsNormally);

    expect(presenter.isInitialized(), true);
  });

  test('test isAuthorized()', () {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(1, 'A', false, false);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    expect(presenter.isAuthorized(), true);
  });

  test('test change user', () {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();

    presenter.attachRepositories(workoutRepo, exerciseRepo);

    expect(() => presenter.changeTemplate(1, 'A', false, false), returnsNormally);
  });

  test('test fetchData() fail', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(1, 'A', false, false);

    presenter.detach();
    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    await presenter.fetchData();

    verify(view.setTemplateData('', '', [])).called(1);
  });

  test('test fetchData() fail fetch exercises', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(1, 'A', false, false);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenThrow(FailedFetchException(''));

    await presenter.fetchData();

    verify(view.setTemplateData('', '', [])).called(1);
  });

  test('test fetchData() fail fetch workouts', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(1, 'A', false, false);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenThrow(FailedFetchException(''));
    when(workoutRepo.fetchTemplate(any, any)).thenThrow(FailedFetchException(''));

    await presenter.fetchData();

    verify(view.setTemplateData('', '', [])).called(1);
  });

  test('test fetchData() fail empty workouts', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(1, 'A', false, false);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout1);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate1);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    String name = 'testname', note = 'testnote';
    List<Widget> list = [];

    when(view.setTemplateData(any, any, any)).thenAnswer((realInvocation) {
      name = realInvocation.positionalArguments[0];
      note = realInvocation.positionalArguments[1];
      list = realInvocation.positionalArguments[2];
    });

    await presenter.fetchData();

    verifyNever(view.notifyNoTemplatesFound());
    expect(list.length, 1);
    expect(name, 'A');
    expect(note, 'A');
  });

  test('test fetchData() success', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(1, 'A', false, false);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout1);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate1);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    List<Widget> list = [];

    when(view.setTemplateData(any, any, any)).thenAnswer((realInvocation) {
      list = realInvocation.positionalArguments[2];
    });

    await presenter.fetchData();

    verifyNever(view.notifyNoTemplatesFound());
    expect(list.length, 1);

    var element1 = list[0] as EditableSetHolder;

    expect(element1.repsControllers.length, 3);
    expect(element1.exerciseController.dropDownValue?.value, 'A');
  });

  test('test delete template', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(1, 'A', false, false);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout1);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate1);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    await presenter.deleteTemplate(1);

    verify(workoutRepo.deleteWorkout(1, 'token')).called(1);
  });

  test('test add set', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(1, 'A', false, false);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout1);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate1);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    List<Widget> list = [];
    when(view.setTemplateData(any, any, any)).thenAnswer((realInvocation) {
      list = realInvocation.positionalArguments[2];
    });

    presenter.addNewSet();

    expect(list.length, 2);

    presenter.addNewSet();

    expect(list.length, 3);
  });

  test('test save changes fail', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(1, 'A', false, false);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => Workout(1, 'name', 'coachNote', 'userId', 'coachId', false, '', '', '', []));
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate1);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    nameController.text = '';
    await presenter.saveChanges();
    verify(view.notifyNoName()).called(1);

    nameController.text = 'Azis';
    await presenter.saveChanges();
    verify(view.notifyNoSets()).called(1);
  });

  test('test save changes fail', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(1, 'A', true, false);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => Workout(1, 'name', 'coachNote', 'userId', 'coachId', false, '', '', '', []));
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => Workout(1, 'name', 'coachNote', 'userId', 'coachId', true, '', '', '', []));
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    nameController.text = '';
    await presenter.saveChanges();
    verify(view.notifyNoName()).called(1);

    nameController.text = 'Azis';
    await presenter.saveChanges();
    verify(view.notifyNoSets()).called(1);
  });

  test('test save changes success', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(1, 'A', false, false);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout1);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate1);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    nameController.text = '';
    await presenter.saveChanges();
    verify(view.notifyNoName()).called(1);

    nameController.text = 'Azis';
    await presenter.saveChanges();
    verify(view.notifySaved()).called(1);
  });

  test('test save changes success', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(1, 'A', true, false);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout1);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate1);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    nameController.text = '';
    await presenter.saveChanges();
    verify(view.notifyNoName()).called(1);

    nameController.text = 'Azis';
    await presenter.saveChanges();
    verify(view.notifySaved()).called(1);
  });

  test('test save changes success', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(1, 'A', false, true);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout1);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate1);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    nameController.text = '';
    await presenter.saveChanges();
    verify(view.notifyNoName()).called(1);

    nameController.text = 'Azis';
    await presenter.saveChanges();
    verify(view.notifySaved()).called(1);
  });

  test('test save changes success', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(1, 'A', true, true);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout1);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate1);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    nameController.text = '';
    await presenter.saveChanges();
    verify(view.notifyNoName()).called(1);

    nameController.text = 'Azis';
    await presenter.saveChanges();
    verify(view.notifySaved()).called(1);
  });

  test('test save changes success', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(1, 'A', false, false);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout2);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate2);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    nameController.text = '';
    await presenter.saveChanges();
    verify(view.notifyNoName()).called(1);

    nameController.text = 'Azis';
    await presenter.saveChanges();
    verify(view.notifySaved()).called(1);
  });

  test('test save changes success', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(1, 'A', true, false);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout2);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate2);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    nameController.text = '';
    await presenter.saveChanges();
    verify(view.notifyNoName()).called(1);

    nameController.text = 'Azis';
    await presenter.saveChanges();
    verify(view.notifySaved()).called(1);
  });

  test('test save changes success', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(1, 'A', true, true);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout2);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate2);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    nameController.text = '';
    await presenter.saveChanges();
    verify(view.notifyNoName()).called(1);

    nameController.text = 'Azis';
    await presenter.saveChanges();
    verify(view.notifySaved()).called(1);
  });

  test('test save changes success', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(1, 'A', false, true);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout2);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate2);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    nameController.text = '';
    await presenter.saveChanges();
    verify(view.notifyNoName()).called(1);

    nameController.text = 'Azis';
    await presenter.saveChanges();
    verify(view.notifySaved()).called(1);
  });

  test('test save changes success', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(0, 'A', false, false);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout2);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate2);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    nameController.text = '';
    await presenter.saveChanges();
    verify(view.notifyNoName()).called(1);

    nameController.text = 'Azis';
    await presenter.saveChanges();
    verify(view.notifySaved()).called(1);
  });

  test('test save changes success', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(0, 'A', true, false);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout2);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate2);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    nameController.text = '';
    await presenter.saveChanges();
    verify(view.notifyNoName()).called(1);

    nameController.text = 'Azis';
    await presenter.saveChanges();
    verify(view.notifySaved()).called(1);
  });

  test('test save changes success', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(0, 'A', false, true);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout2);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate2);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    nameController.text = '';
    await presenter.saveChanges();
    verify(view.notifyNoName()).called(1);

    nameController.text = 'Azis';
    await presenter.saveChanges();
    verify(view.notifySaved()).called(1);
  });

  test('test save changes success', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(0, 'A', true, true);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout2);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate2);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    nameController.text = '';
    await presenter.saveChanges();
    verify(view.notifyNoName()).called(1);

    nameController.text = 'Azis';
    await presenter.saveChanges();
    verify(view.notifySaved()).called(1);
  });

  test('test save changes success id 0', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(0, 'A', false, false);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout1);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate1);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    nameController.text = '';
    await presenter.saveChanges();
    verify(view.notifyNoName()).called(1);

    nameController.text = 'Azis';
    await presenter.saveChanges();
    verify(view.notifySaved()).called(1);
  });

  test('test save changes success id 0', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(0, 'A', true, false);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout1);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate1);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    nameController.text = '';
    await presenter.saveChanges();
    verify(view.notifyNoName()).called(1);

    nameController.text = 'Azis';
    await presenter.saveChanges();
    verify(view.notifySaved()).called(1);
  });

  test('test save changes success id 0', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(0, 'A', false, true);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout1);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate1);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    nameController.text = '';
    await presenter.saveChanges();
    verify(view.notifyNoName()).called(1);

    nameController.text = 'Azis';
    await presenter.saveChanges();
    verify(view.notifySaved()).called(1);
  });

  test('test save changes success id 0', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(0, 'A', true, true);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout1);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate1);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    nameController.text = '';
    await presenter.saveChanges();
    verify(view.notifyNoName()).called(1);

    nameController.text = 'Azis';
    await presenter.saveChanges();
    verify(view.notifySaved()).called(1);
  });

  test('test save changes success id 0', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(0, 'A', true, false);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout1);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate1);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    nameController.text = '';
    await presenter.saveChanges();
    verify(view.notifyNoName()).called(1);

    nameController.text = 'Azis';
    await presenter.saveChanges();
    verify(view.notifySaved()).called(1);
  });

  test('test save changes success id 0', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(0, 'A', false, true);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout1);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate1);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    nameController.text = '';
    await presenter.saveChanges();
    verify(view.notifyNoName()).called(1);

    nameController.text = 'Azis';
    await presenter.saveChanges();
    verify(view.notifySaved()).called(1);
  });

  test('test save changes success id 0', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(0, 'A', true, true);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout1);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate1);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    nameController.text = '';
    await presenter.saveChanges();
    verify(view.notifyNoName()).called(1);

    nameController.text = 'Azis';
    await presenter.saveChanges();
    verify(view.notifySaved()).called(1);
  });

  test('test save changes success id 0', () async {
    final workoutRepo = MockWorkoutRepository();
    final exerciseRepo = MockExerciseRepository();
    final presenter = WorkoutPagePresenter();
    final view = MockWorkoutPageView();
    final nameController = TextEditingController(), noteController = TextEditingController();

    presenter.attachRepositories(workoutRepo, exerciseRepo);
    presenter.changeTemplate(0, 'A', false, false);

    presenter.attach(view);

    final appState = AppState();
    appState.setInitialState('A', 'token', [Role('A', 'admin')]);

    presenter.setAppState(appState);

    when(exerciseRepo.getExercises()).thenAnswer((realInvocation) async => [Exercise('bodypart1', 'equipment1', 'gifUrl1', 'name1', 'muscleGroup1'), Exercise('bodypart2', 'equipment2', 'gifUrl2', 'name2', 'muscleGroup2'), Exercise('bodypart3', 'equipment3', 'gifUrl3', 'name3', 'muscleGroup3'), ]);
    when(workoutRepo.fetchWorkout(any, any)).thenAnswer((realInvocation) async => MockData.testWorkout2);
    when(workoutRepo.fetchTemplate(any, any)).thenAnswer((realInvocation) async => MockData.testWorkoutTemplate1);
    when(view.noteController).thenReturn(noteController);
    when(view.nameController).thenReturn(nameController);

    await presenter.fetchData();

    nameController.text = '';
    await presenter.saveChanges();
    verify(view.notifyNoName()).called(1);

    nameController.text = 'Azis';
    await presenter.saveChanges();
    verify(view.notifySaved()).called(1);
  });
}
