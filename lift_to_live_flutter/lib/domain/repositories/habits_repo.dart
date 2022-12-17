import '../entities/habit.dart';
import '../entities/habit_task.dart';

/// API to the Habits repository object.
/// Defines method to be implemented.
abstract class HabitsRepository {
  /// This function is used to patch a habit instance.
  Future<void> patchHabit(int id, String date, String note, String userId,
      String coachId, List<HabitTask> habits, String jwtToken);

  /// This function is used for fetching the habits template for a user.
  Future<Habit> fetchTemplate(String userId, String jwtToken);

  /// This function is used for fetching all habit entries for a user.
  Future<List<Habit>> fetchHabits(String userId, String jwtToken);

  /// This function is used for posting habit entries.
  Future<void> postHabit(String date, String note, String userId,
      String coachId, bool isTemplate, List<HabitTask> habits, String jwtToken);
}
