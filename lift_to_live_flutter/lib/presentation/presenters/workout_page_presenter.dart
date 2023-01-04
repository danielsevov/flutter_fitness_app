import 'dart:developer';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/domain/entities/exercise.dart';
import 'package:lift_to_live_flutter/domain/entities/workout.dart';
import 'package:lift_to_live_flutter/domain/repositories/exercise_repo.dart';
import 'package:lift_to_live_flutter/domain/repositories/workout_repo.dart';
import 'package:lift_to_live_flutter/presentation/presenters/base_presenter.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/set_task_holder.dart';
import '../../domain/entities/workout_set.dart';
import '../ui/widgets/workout_related/template_set_holder.dart';
import '../views/workout_page_view.dart';

/// This is the object, which holds the business logic, related to the user Workout Page view.
/// It is the mediator between the WorkoutPage view (UI) and the repositories (Data).
class WorkoutPagePresenter extends BasePresenter {
  WorkoutPageView? _view;
  late int _templateId;
  late String _userId;
  late bool _forTemplate, _fromTemplate;
  int tag = 0;

  late final WorkoutRepository _workoutRepository;
  late final ExerciseRepository _exerciseRepository;
  late List<String> _exerciseNames;

  final List<TemplateSetHolder> _templateSetWidgets = [];

  String creationDate = '';

  /// Simple constructor
  WorkoutPagePresenter();

  /// Function to attach repositories
  void attachRepositories(
      WorkoutRepository repo, ExerciseRepository exerciseRepository) {
    _workoutRepository = repo;
    _exerciseRepository = exerciseRepository;
    super.repositoriesAttached = true;
  }

  /// Function called when presenter is being reused for other template.
  void changeTemplate(int id, String userId, bool forTemplate, bool fromTemplate) {
    _templateSetWidgets.clear();
    _templateId = id;
    _userId = userId;
    _forTemplate = forTemplate;
    _fromTemplate = fromTemplate;
  }

  /// Function to attach a view to the presenter
  void attach(WorkoutPageView view) {
    _view = view;
  }

  /// Function to detach the view from the presenter
  void detach() {
    _view = null;
  }

  /// Function called to indicate if user is authorized to edit the workouts for the page owner.
  bool isAuthorized() {
    return super.appState.isCoachOrAdmin();
  }

  Future<void> saveChanges() async {
    if(_forTemplate) {
      String coachNote = _view?.noteController.text;
      String name = _view?.nameController.text;

      if(name.isEmpty) {
        _view?.notifyNoName();
        return;
      }

      List<WorkoutSet> workoutSets = [];
      for (var temp in _templateSetWidgets) {
        var workSet = temp.toWorkoutSet();
        if(workSet.reps.isNotEmpty) workoutSets.add(workSet);
      }

      if(workoutSets.isEmpty) {
        _view?.notifyNoSets();
        return;
      }

      log(name);
      log(coachNote);
      log(creationDate);

      for (var element in workoutSets) {
        log(element.toString());
      }

      if(_templateId != 0) {
        await _workoutRepository.patchWorkout(_templateId, coachNote, '', _userId, appState.getUserId(), workoutSets, '', creationDate, name, '', true, appState.getToken());
      }
      else {
        await _workoutRepository.postWorkout(coachNote, '', _userId, appState.getUserId(), workoutSets, '', creationDate, name, '', true, appState.getToken());
      }

      _view?.notifySaved();
    }

    else {
      String coachNote = _view?.noteController.text;
      String completedOn = (DateTime.now().millisecondsSinceEpoch).toString();
      String name = _view?.nameController.text;

      if(name.isEmpty) {
        _view?.notifyNoName();
        return;
      }

      bool isCompleted = true;
      List<WorkoutSet> workoutSets = [];
      for (var temp in _templateSetWidgets) {
        var workSet = temp.toWorkoutSet();
        if(!workSet.isCompleted) isCompleted = false;
        if(workSet.reps.isNotEmpty) workoutSets.add(workSet);
      }

      if(workoutSets.isEmpty) {
        _view?.notifyNoSets();
        return;
      }

      log(name);
      log(coachNote);
      log(creationDate);

      for (var element in workoutSets) {
        log(element.toString());
      }

      if(_templateId != 0) {
        if(isCompleted) {
          await _workoutRepository.patchWorkout(_templateId, coachNote, '', _userId, appState.getUserId(), workoutSets, completedOn, creationDate, name, '0', false, appState.getToken());
        } else {
          await _workoutRepository.patchWorkout(_templateId, coachNote, '', _userId, appState.getUserId(), workoutSets, '', creationDate, name, '0', false, appState.getToken());
        }
      }
      else {
        if(isCompleted) {
          await _workoutRepository.postWorkout(coachNote, '', _userId, appState.getUserId(), workoutSets, completedOn, creationDate, name, '0', false, appState.getToken());
        }
        else {
          await _workoutRepository.postWorkout(coachNote, '', _userId, appState.getUserId(), workoutSets, '', creationDate, name, '0', false, appState.getToken());
        }
      }

      _view?.notifySaved();
    }
  }

  /// Function used for deleting a workout template.
  Future<void> deleteTemplate(int templateId) async {
    await _workoutRepository.deleteWorkout(templateId, appState.getToken());
  }

  /// Function used to attach a new exercise set and display it on the page view.
  void addNewSet() {
    List<SetTaskHolder> setTaskItems = [];
    List<TextEditingController> repControllers = [],
        kiloControllers = [],
        isCompletedControllers = [];

    _templateSetWidgets.add(TemplateSetHolder(
        setTasks: setTaskItems,
        exerciseController: SingleValueDropDownController(),
        noteController: TextEditingController(),
        isEnabled: true,
        exercises: _exerciseNames,
        presenter: this,
        repsControllers: repControllers,
        kilosControllers: kiloControllers,
        isCompletedControllers: isCompletedControllers, tag: '${tag++}', isTemplate: _forTemplate,));
    _view?.setTemplateData(_view?.nameController.text, _view?.noteController.text, _templateSetWidgets);
  }

  /// Function used for fetching the required data, which is then displayed on the workout templates page.
  Future<void> fetchData() async {
    // set the loading indicator to be displayed on the home page view
    _view?.setInProgress(true);
    changeTemplate(_templateId, _userId, _forTemplate, _fromTemplate);

    // fetch the user workouts
    try {
      // fetch all exercise entries
      List<Exercise> exercises = await _exerciseRepository.getExercises();

      _exerciseNames = exercises.map((e) => e.name).toList();

      // fetch single user workout
      Workout template;

      if(_forTemplate || _fromTemplate) {
        template = await _workoutRepository.fetchTemplate(
            _templateId, appState.getToken());

        if(_fromTemplate && !_forTemplate) {
          _templateId = 0;
          template.id = 0;
          template.isTemplate = false;
        }
      }
      else {
        template = await _workoutRepository.fetchWorkout(
            _templateId, appState.getToken());
      }

      if(_templateId == 0) {
        template.userId = _userId;
        template.coachId = appState.getUserId();
        template.createdOn = (DateTime.now().millisecondsSinceEpoch).toString();
      }

      creationDate = template.createdOn;

      _view?.nameController.text = template.name;
      _view?.noteController.text = template.coachNote;

      // create a list of TemplateSetHolders
      for (var item in template.sets) {
        var exerciseController = SingleValueDropDownController();
        var noteController = TextEditingController();

        exerciseController.dropDownValue =
            DropDownValueModel(name: item.exercise, value: item.exercise);
        noteController.text = item.setNote;

        List<SetTaskHolder> workoutSetItems = [];
        final List<TextEditingController> reps = [], kilos = [], completes = [];

        // create a list of SetTaskHolders
        for (int i = 0; i < item.reps.length; i++) {
          var repsController = TextEditingController();
          var kilosController = TextEditingController();
          var isCompletedController = TextEditingController();

          repsController.text = item.reps[i].toString();
          kilosController.text = item.kilos[i].toString();
          isCompletedController.text = item.isCompleted.toString();

          reps.add(repsController);
          kilos.add(kilosController);
          completes.add(isCompletedController);

          workoutSetItems.add(SetTaskHolder(
            repsController: repsController,
            kilosController: kilosController,
            isCompletedController: isCompletedController,
            isEnabled: true,
            isTemplate: _forTemplate,
          ));
        }

        var workoutSet = TemplateSetHolder(
          setTasks: workoutSetItems,
          exerciseController: exerciseController,
          noteController: noteController,
          isEnabled: true,
          exercises: _exerciseNames,
          presenter: this,
          repsControllers: reps,
          kilosControllers: kilos,
          isCompletedControllers: completes,  tag: '${tag++}', isTemplate: _forTemplate,
        );
        _templateSetWidgets.add(workoutSet);
      }

      // notify the page view that the fetch is complete
      _view?.setInProgress(false);
      _view?.setTemplateData(_view?.nameController.text, _view?.noteController.text, _templateSetWidgets);
      _view?.setFetched(true);
    }

    catch (e) {
      _view?.notifyNoTemplatesFound();
      _view?.setTemplateData('' , '', _templateSetWidgets);
      _view?.setInProgress(false);
      _view?.setFetched(true);
    }
  }
}
