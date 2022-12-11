import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/domain/entities/habit_task.dart';
import 'package:lift_to_live_flutter/domain/repositories/habits_repo.dart';
import 'package:lift_to_live_flutter/helper.dart';
import 'package:lift_to_live_flutter/presentation/presenters/base_presenter.dart';
import '../../domain/entities/habit.dart';
import '../ui/widgets/habit_holder.dart';
import '../ui/widgets/habit_task_holder.dart';
import '../views/habits_page_view.dart';

/// This is the object, which holds the business logic, related to the user Habits Page view.
/// It is the mediator between the HabitsPage view (UI) and the repositories (Data).
class HabitsPagePresenter extends BasePresenter{
  HabitsPageView? _view;

  final HabitsRepository _habitsRepository;
  List<Habit> _habits = [];
  final List<Widget> _habitWidgets = [];
  late Habit template;
  final String _userId;

  /// Simple constructor for passing the required repositories
  HabitsPagePresenter(this._habitsRepository, this._userId);

  /// Function to attach a view to the presenter
  void attach(HabitsPageView view) {
    _view = view;
  }

  /// Function to detach the view from the presenter
  void detach() {
    _view = null;
  }

  /// Function called to indicate if user is authorized to view private pages.
  isAuthorized() {
    return super.appState.isCoachOrAdmin();
  }

  /// Function called to indicate if user is the owner of the page.
  isOwner() {
    return super.appState.getUserId() == _userId;
  }

  /// Function to get all habits
  List<Habit> get habits => _habits;

  /// Function used for fetching the required data, which is then displayed on the habits page.
  Future<void> fetchData() async {
    // set the loading indicator to be displayed on the home page view
    _view?.setInProgress(true);

    // fetch the user details and profile picture
    try {
      template = await _habitsRepository.fetchTemplate(
          _userId, appState.getToken());

      //create template if not present\
      if(template.id == 0) {
        await _habitsRepository.postHabit(
            (DateTime.now().millisecondsSinceEpoch).toString(),
            template.note,
            _userId,
            appState.getUserId(),
            true,
            template.habits,
            appState.getToken());

        template = await _habitsRepository.fetchTemplate(
            _userId, appState.getToken());
      }

      _habits = await _habitsRepository.fetchHabits(
          _userId, appState.getToken());

      //sort by date
      _habits.sort((a, b) => b.date.compareTo(a.date));

      //create today's habit if not present
      if ((_habits.isEmpty ||
          Helper.isDateBeforeToday(_habits.first.date))) {
        await _habitsRepository.postHabit(
            (DateTime.now().millisecondsSinceEpoch).toString(),
            template.note,
            template.userId,
            template.coachId,
            false,
            template.habits,
            appState.getToken());

        _habits = await _habitsRepository.fetchHabits(
            _userId, appState.getToken());

        //sort by date
        _habits.sort((a, b) => b.date.compareTo(a.date));
      }

      //add list of habitTasks widgets (1 for each habit task in a habit instance)
      for (Habit element in _habits) {
        final habitTaskWidgets = <Widget>[];
        Habit habit = element;
        for (var element in habit.habits) {
          habitTaskWidgets.add(HabitTaskHolder(
            habitTask: element, habit: habit, presenter: this,));
        }

        //add habit tasks to the habit instance widget
        _habitWidgets
            .add(HabitHolder(habit: habit, habitTaskWidgets: habitTaskWidgets));
      }

      _habitWidgets.add(const SizedBox(
        height: 10,
      ));

      _view?.setInProgress(false);
      _view?.setHabitData(_habitWidgets);
      _view?.setFetched(true);
    }
    catch (e) {
      _view?.notifyNoHabitsFound();
      _habitWidgets.add(const Text('No Habits were found!'));
      _view?.setHabitData(_habitWidgets);
      _view?.setInProgress(false);
      _view?.setFetched(true);
    }
  }

  void updateHabitEntry(int id, String date, String note, String userId, String coachId, List<HabitTask> habits) {
    _habitsRepository.patchHabit(id, date, note, userId, coachId, habits, appState.getToken());
  }
}
