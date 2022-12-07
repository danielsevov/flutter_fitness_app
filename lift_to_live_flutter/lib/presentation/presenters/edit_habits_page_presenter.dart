
import '../../domain/entities/habit.dart';
import '../../domain/entities/habit_task.dart';
import '../../domain/repositories/habits_repo.dart';
import '../views/edit_habits_page_view.dart';
import 'base_presenter.dart';

/// This is the object, which holds the business logic, related to the user Habits Page view.
/// It is the mediator between the EditHabitsPage view (UI) and the repositories (Data).
class EditHabitsPagePresenter extends BasePresenter{
  EditHabitsPageView? _view;

  final HabitsRepository _habitsRepository;
  late Habit template;
  final String _userId;

  /// Simple constructor for passing the required repositories
  EditHabitsPagePresenter(this._habitsRepository, this._userId);

  /// Function to attach a view to the presenter
  void attach(EditHabitsPageView view) {
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

  /// Function used for fetching the required data, which is then displayed on the habits page.
  Future<void> fetchData() async {
    _view?.clear();

    // set the loading indicator to be displayed on the home page view
    _view?.setInProgress(true);

    // fetch the user details and profile picture
    try {
      template = await _habitsRepository.fetchTemplate(
          _userId, appState.getUserId(), appState.getToken());

      for (var element in template.habits) {
        _view?.addTaskElement(element.task, () => _view?.refresh());
      }

      _view?.setInProgress(false);
      _view?.setFetched(true);

    }

    catch (e) {
      _view?.setInProgress(false);
    }
  }

  void patchHabit(int id, String date, String note, String userId, String coachId, List<HabitTask> habits) {
    _habitsRepository.patchHabit(id, date, note, userId, coachId, habits, appState.getToken());
  }

  void saveChanges() {
    List<HabitTask> newTasks = [];
    var controllers = _view?.getControllers();

    controllers?.map((e) => e.text.toString()).forEach((element) {
      if(element.isNotEmpty) newTasks.add(HabitTask(element, false));
    });

    patchHabit(
        template.id,
        (DateTime.now().millisecondsSinceEpoch).toString(),
        template.note,
        _userId,
        appState.getUserId(),
        newTasks);

    _view?.notifySavedChanges();
  }

  void addNewElement() {
    _view?.addTaskElement('Enter task here', () => _view?.refresh());
  }
}
