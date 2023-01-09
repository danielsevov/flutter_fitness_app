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
import '../../factory/page_factory.dart';
import '../ui/widgets/workout_related/workout_holder.dart';
import '../views/workout_history_page_view.dart';

/// This is the object, which holds the business logic, related to the user Workout History Page view.
/// It is the mediator between the WorkoutHistoryPage view (UI) and the repositories (Data).
class WorkoutHistoryPagePresenter extends BasePresenter {
  WorkoutHistoryPageView? _view;

  late final WorkoutRepository _workoutRepository;
  late final ExerciseRepository _exerciseRepository;
  List<Workout> _workouts = [];
  late List<Exercise> _exercises;
  final List<Widget> _workoutWidgets = [];
  final List<String> _workoutDates = [];
  late String userId;

  /// Simple constructor
  WorkoutHistoryPagePresenter();

  /// Function to attach repositories
  void attachRepositories(
      WorkoutRepository repo, ExerciseRepository exerciseRepository) {
    _workoutRepository = repo;
    _exerciseRepository = exerciseRepository;
    super.repositoriesAttached = true;
  }

  /// Function called when presenter is being reused with another user.
  void changeUser(String userID) {
    _workoutWidgets.clear();
    userId = userID;
  }

  /// Function to attach a view to the presenter
  void attach(WorkoutHistoryPageView view) {
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

  /// Function to get all workout entries.
  List<Workout> get workouts => _workouts;

  /// Function used for fetching the required data, which is then displayed on the workout history page.
  Future<void> fetchData() async {
    // set the loading indicator to be displayed on the home page view
    _view?.setInProgress(true);
    _workoutDates.clear();
    _workoutWidgets.clear();

    // fetch the user workouts
    try {
      // fetch all exercise entries
      _exercises = await _exerciseRepository.getExercises();

      var exerciseNames = _exercises.map((e) => e.name).toList();

      // fetch all user workout entries
      _workouts =
          await _workoutRepository.fetchWorkouts(userId, appState.getToken());

      //sort by date
      _workouts.sort((a, b) => b.createdOn.compareTo(a.createdOn));

      //add list of workoutSets widgets (1 for each habit task in a habit instance)
      for (Workout element in _workouts) {
        log(element.name);
        final workoutSetWidgets = <FixedSetHolder>[];

        // create a list of WorkoutSetHolders
        int j = 0;
        int totalVolume = 0;
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

          // create a list of SetTaskHolder
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

            totalVolume += item.reps[i] * item.kilos[i];

            workoutSetItems.add(SetTaskHolder(
              repsController: repsController,
              kilosController: kilosController,
              isCompletedController: isCompletedController,
              isEnabled: false,
              isTemplate: false,
            ));
          }

          var workoutSet = FixedSetHolder(
            setTasks: workoutSetItems,
            exerciseController: exerciseController,
            noteController: noteController,
            exercises: exerciseNames,
            setIndex: j,
            isTemplate: false,
          );
          workoutSetWidgets.add(workoutSet);
        }

        //add workout tasks to the workout instance widget
        _workoutDates.add(element.createdOn);
        _workoutWidgets.add(WorkoutHolder(
          workoutSetItems: workoutSetWidgets,
          name: element.name,
          note: element.coachNote,
          created: element.createdOn,
          completed: element.completedOn,
          duration: element.duration,
          totalVolume: '$totalVolume kgs',
          userId: element.userId,
          id: element.id,
          // coverage:ignore-line
          onEdit: (BuildContext context) { Helper.replacePage( context, PageFactory().getWorkoutPage(element.id, element.userId, false, false));},
        ));
      }

      // add the bottom margin space
      _workoutWidgets.add(const SizedBox(
        height: 10,
      ));

      // notify the page view that the fetch is complete
      _view?.setInProgress(false);
      _view?.setWorkoutData(_workoutWidgets, _workoutDates);
      _view?.setFetched(true);
    } catch (e) {
      _view?.notifyNoWorkoutsFound();
      _workoutWidgets.add(const Text(
        'No Workouts were found!',
        style: TextStyle(color: Helper.whiteColor),
      ));
      _view?.setWorkoutData(_workoutWidgets, _workoutDates);
      _view?.setInProgress(false);
      _view?.setFetched(true);
    }
  }
}
