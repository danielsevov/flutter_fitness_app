import '../../domain/entities/habit.dart';
import '../../domain/entities/habit_task.dart';
import '../../domain/repositories/habits_repo.dart';
import '../views/edit_habits_page_view.dart';
import 'base_presenter.dart';

/// This is the object, which holds the business logic, related to the user Edit Habits Page view.
/// It is the mediator between the EditHabitsPage view (UI) and the repositories (Data).
class EditHabitsPagePresenter extends BasePresenter {
  EditHabitsPageView? _view;

  late final HabitsRepository _habitsRepository;
  late Habit template;
  late String _userId;

  /// Simple constructor
  EditHabitsPagePresenter();

  /// Function to attach repositories
  void attachRepositories(HabitsRepository habitsRepository) {
    _habitsRepository = habitsRepository;
    super.repositoriesAttached = true;
  }

  void changeUser(String userID) {
    _userId = userID;
  }

  /// Function to attach a view to the presenter
  void attach(EditHabitsPageView view) {
    _view = view;
  }

  /// Function to detach the view from the presenter
  void detach() {
    _view = null;
  }

  /// Function called to indicate if user is authorized to edit habits.
  isAuthorized() {
    return super.appState.isCoachOrAdmin();
  }

  /// Function used for fetching the required data, which is then displayed on the edit habits page.
  Future<void> fetchData() async {
    _view?.clear();

    // set the loading indicator to be displayed on the page view
    _view?.setInProgress(true);

    // fetch the template habit
    try {
      template =
          await _habitsRepository.fetchTemplate(_userId, appState.getToken());

      // create edit habit widgets for each task
      for (var element in template.habits) {
        _view?.addTaskElement(element.task, () => _view?.refresh());
      }

      // notify the page view that fetch is complete
      _view?.setInProgress(false);
      _view?.setFetched(true);
    } catch (e) {
      _view?.setInProgress(false);
    }
  }

  /// This function is used when the user clicks on Save Changes button on the page view to store the habit template changes.
  void saveChanges() {
    List<HabitTask> newTasks = [];
    // get the text editing controllers from the view
    var controllers = _view?.getControllers();

    // create the Habit tasks
    controllers?.map((e) => e.text.toString()).forEach((element) {
      if (element.isNotEmpty) newTasks.add(HabitTask(element, false));
    });

    // update the habit template
    _habitsRepository.patchHabit(
        template.id,
        (DateTime.now().millisecondsSinceEpoch).toString(),
        template.note,
        _userId,
        appState.getUserId(),
        newTasks,
        appState.getToken());

    // notify the page view that the patch is complete
    _view?.notifySavedChanges();
  }

  /// Function for adding a new edit habit task element to the page view.
  void addNewElement() {
    _view?.addTaskElement('Enter task here', () => _view?.refresh());
  }
}
