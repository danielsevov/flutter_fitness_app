import '../entities/habit.dart';
import '../entities/habit_task.dart';

/// API to the Habits repository object.
/// Defines method to be implemented.
abstract class HabitsRepository {
  /// function to patch a habit instance
  Future<void> patchHabit(int id, String date, String note, String userId,
      String coachId, List<HabitTask> habits, String jwtToken);

  /// function for fetching habits template
  Future<Habit> fetchTemplate(String userId, String coachId, String jwtToken);

  Future<List<Habit>> fetchHabits(String userId, String jwtToken);

  /// function for posting habits
  Future<void> postHabit(String date,
      String note,
      String userId,
      String coachId,
      bool isTemplate,
      List<HabitTask> habits,
      String jwtToken);
}
