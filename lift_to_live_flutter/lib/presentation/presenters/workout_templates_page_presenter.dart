import 'dart:developer';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/domain/entities/exercise.dart';
import 'package:lift_to_live_flutter/domain/entities/workout.dart';
import 'package:lift_to_live_flutter/domain/repositories/exercise_repo.dart';
import 'package:lift_to_live_flutter/domain/repositories/workout_repo.dart';
import 'package:lift_to_live_flutter/helper.dart';
import 'package:lift_to_live_flutter/presentation/presenters/base_presenter.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/fixed_set_holder.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/set_task_holder.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/template_workout_holder.dart';
import '../../factory/page_factory.dart';
import '../views/workout_templates_page_view.dart';

/// This is the object, which holds the business logic, related to the user Workout Templates Page view.
/// It is the mediator between the WorkoutTemplatesPage view (UI) and the repositories (Data).
class WorkoutTemplatesPagePresenter extends BasePresenter {
  WorkoutTemplatesPageView? _view;

  late final WorkoutRepository _workoutRepository;
  late final ExerciseRepository _exerciseRepository;
  List<Workout> _workouts = [];
  late List<Exercise> _exercises;
  final List<Widget> _workoutWidgets = [];
  late String userId;

  /// Simple constructor
  WorkoutTemplatesPagePresenter();

  /// Function to attach repositories
  void attachRepositories(
      WorkoutRepository repo, ExerciseRepository exerciseRepository) {
    _workoutRepository = repo;
    _exerciseRepository = exerciseRepository;
    super.repositoriesAttached = true;
  }

  /// Function called when presenter is being reused for another user.
  void changeUser(String userID) {
    _workoutWidgets.clear();
    userId = userID;
  }

  /// Function to attach a view to the presenter
  void attach(WorkoutTemplatesPageView view) {
    _view = view;
  }

  /// Function to detach the view from the presenter
  void detach() {
    _view = null;
  }

  /// Function called to indicate if user is authorized to edit the workouts for the page owner.
  isAuthorized() {
    return super.appState.isCoachOrAdmin();
  }

  /// Function called to indicate if user is the owner of the page.
  isOwner() {
    return super.appState.getUserId() == userId;
  }

  Future<void> copyWorkout(int id) async {
    var workout = workouts.firstWhere((element) => element.id == id);
    String createdOn = (DateTime.now().millisecondsSinceEpoch).toString();
    await _workoutRepository.postWorkout(workout.coachNote, '', workout.userId, appState.getUserId(), workout.sets, '', createdOn, '${workout.name} (Copy)', '', workout.isTemplate, appState.getToken());

    _view?.notifyNewTemplate();
    fetchData();
  }

  /// Function to get all workout entries.
  List<Workout> get workouts => _workouts;

  /// Function used for fetching the required data, which is then displayed on the workout templates page.
  Future<void> fetchData() async {
    // set the loading indicator to be displayed on the home page view
    _view?.setInProgress(true);
    _workoutWidgets.clear();

    // fetch the user workouts
    try {
      // fetch all exercise entries
      _exercises = await _exerciseRepository.getExercises();

      var exerciseNames = _exercises.map((e) => e.name).toList();

      // fetch all user workout entries
      _workouts =
          await _workoutRepository.fetchTemplates(userId, appState.getToken());

      log(_workouts.length.toString());

      //sort by date
      _workouts.sort((a, b) => b.createdOn.compareTo(a.createdOn));

      //add list of workoutSets widgets (1 for each habit task in a habit instance)
      for (Workout element in _workouts) {
        log(element.name);
        final workoutSetWidgets = <FixedSetHolder>[];

        // create e list of WorkoutSetHolders
        int j = 0;
        for (var item in element.sets) {
          j++;
          var exerciseController = SingleValueDropDownController();
          var noteController = TextEditingController();

          exerciseController.dropDownValue =
              DropDownValueModel(name: item.exercise, value: item.exercise);
          noteController.text = item.setNote;

          List<SetTaskHolder> workoutSetItems = [];
          final List<TextEditingController> reps = [],
              kilos = [],
              completes = [];

          // create e list of SetTaskHolders
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
              isEnabled: false,
              isTemplate: true,
            ));
          }

          var workoutSet = FixedSetHolder(
            setTasks: workoutSetItems,
            exerciseController: exerciseController,
            noteController: noteController,
            exercises: exerciseNames,
            isTemplate: true,
            setIndex: j,
          );
          workoutSetWidgets.add(workoutSet);
        }

        //add workout tasks to the workout instance widget
        _workoutWidgets.add(TemplateWorkoutHolder(
          workoutSetItems: workoutSetWidgets,
          name: element.name,
          note: element.coachNote,
          creationDate: element.createdOn,
          id: element.id,
          userId: element.userId,
          // coverage:ignore-start
          onSubmit: () { copyWorkout(element.id); }, onEdit: (BuildContext context){
          Helper.replacePage(context, PageFactory().getWorkoutPage(element.id, element.userId, true, true));},
          onStartWorkout: (BuildContext context){
          Helper.replacePage(context, PageFactory().getWorkoutPage(element.id, element.userId, false, true));},
          // coverage:ignore-end
        ));
      }

      // add the bottom margin space
      _workoutWidgets.add(const SizedBox(
        height: 10,
      ));

      // notify the page view that the fetch is complete
      _view?.setInProgress(false);
      _view?.setWorkoutData(_workoutWidgets);
      _view?.setFetched(true);
    }

    catch (e) {
      _view?.notifyNoTemplateWorkoutsFound();
      _workoutWidgets.add(const Text(
        'No Workout templates were found!',
        style: TextStyle(color: Helper.whiteColor),
      ));
      _view?.setWorkoutData(_workoutWidgets);
      _view?.setInProgress(false);
      _view?.setFetched(true);
    }
  }
}
