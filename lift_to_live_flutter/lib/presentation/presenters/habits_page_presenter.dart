import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/domain/entities/habit_task.dart';
import 'package:lift_to_live_flutter/domain/repositories/habits_repo.dart';
import 'package:lift_to_live_flutter/helper.dart';
import 'package:lift_to_live_flutter/presentation/presenters/base_presenter.dart';
import '../../domain/entities/habit.dart';
import '../ui/widgets/habit_related/habit_holder.dart';
import '../ui/widgets/habit_related/habit_task_holder.dart';
import '../views/habits_page_view.dart';

/// This is the object, which holds the business logic, related to the user Habits Page view.
/// It is the mediator between the HabitsPage view (UI) and the repositories (Data).
class HabitsPagePresenter extends BasePresenter {
  HabitsPageView? _view;

  late final HabitsRepository _habitsRepository;
  List<Habit> _habits = [];
  final List<Widget> _habitWidgets = [];
  late Habit template;
  late String userId;

  /// Simple constructor
  HabitsPagePresenter();

  /// Function to attach repositories
  void attachRepositories(HabitsRepository habitsRepository) {
    _habitsRepository = habitsRepository;
    super.repositoriesAttached = true;
  }

  void changeUser(String userID) {
    _habitWidgets.clear();
    userId = userID;
  }

  /// Function to attach a view to the presenter
  void attach(HabitsPageView view) {
    _view = view;
  }

  /// Function to detach the view from the presenter
  void detach() {
    _view = null;
  }

  /// Function called to indicate if user is authorized to edit the habit template for the page owner.
  isAuthorized() {
    return super.appState.isCoachOrAdmin();
  }

  /// Function called to indicate if user is the owner of the page.
  isOwner() {
    return super.appState.getUserId() == userId;
  }

  /// Function to get all habit entries.
  List<Habit> get habits => _habits;

  /// Function used for fetching the required data, which is then displayed on the habits page.
  Future<void> fetchData() async {
    // set the loading indicator to be displayed on the home page view
    _view?.setInProgress(true);

    // fetch the user habit template
    try {
      template =
          await _habitsRepository.fetchTemplate(userId, appState.getToken());

      //create template if not present\
      if (template.id == 0) {
        await _habitsRepository.postHabit(
            (DateTime.now().millisecondsSinceEpoch).toString(),
            template.note,
            userId,
            appState.getUserId(),
            true,
            template.habits,
            appState.getToken());

        // re-fetch the habit template
        template =
            await _habitsRepository.fetchTemplate(userId, appState.getToken());
      }

      // fetch all user habit entries
      _habits =
          await _habitsRepository.fetchHabits(userId, appState.getToken());

      //sort by date
      _habits.sort((a, b) => b.date.compareTo(a.date));

      //create today's habit if not present
      if ((_habits.isEmpty || Helper.isDateBeforeToday(_habits.first.date))) {
        await _habitsRepository.postHabit(
            (DateTime.now().millisecondsSinceEpoch).toString(),
            template.note,
            template.userId,
            template.coachId,
            false,
            template.habits,
            appState.getToken());

        _habits =
            await _habitsRepository.fetchHabits(userId, appState.getToken());

        //sort by date
        _habits.sort((a, b) => b.date.compareTo(a.date));
      }

      //add list of habitTasks widgets (1 for each habit task in a habit instance)
      for (Habit element in _habits) {
        final habitTaskWidgets = <Widget>[];
        Habit habit = element;
        for (var element in habit.habits) {
          habitTaskWidgets.add(HabitTaskHolder(
            habitTask: element,
            habit: habit,
            presenter: this,
          ));
        }

        //add habit tasks to the habit instance widget
        _habitWidgets
            .add(HabitHolder(habit: habit, habitTaskWidgets: habitTaskWidgets));
      }

      // add the bottom margin space
      _habitWidgets.add(const SizedBox(
        height: 10,
      ));

      // notify the page view that the fetch is complete
      _view?.setInProgress(false);
      _view?.setHabitData(_habitWidgets);
      _view?.setFetched(true);
    } catch (e) {
      _view?.notifyNoHabitsFound();
      _habitWidgets.add(const Text('No Habits were found!'));
      _view?.setHabitData(_habitWidgets);
      _view?.setInProgress(false);
      _view?.setFetched(true);
    }
  }

  /// Function for updating a habit entry.
  void updateHabitEntry(int id, String date, String note, String userId,
      String coachId, List<HabitTask> habits) {
    _habitsRepository.patchHabit(
        id, date, note, userId, coachId, habits, appState.getToken());
  }
}
