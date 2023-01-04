import '../entities/workout.dart';
import '../entities/workout_set.dart';

/// API to the Workout repository object.
/// Defines method to be implemented.
abstract class WorkoutRepository {
  /// This function is used to patch a workout instance.
  Future<void> patchWorkout(int id, String coachNote, String note, String userId,
      String coachId, List<WorkoutSet> workoutSets, String completedOn, String createdOn, String name, String duration, bool isTemplate, String jwtToken);

  /// This function is used for fetching the workout templates for a user.
  Future<List<Workout>> fetchTemplates(String userId, String jwtToken);

  /// This function is used for deleting a workout entry.
  Future<void> deleteWorkout(int id, String jwtToken);

  /// This function is used for fetching all workout entries for a user.
  Future<List<Workout>> fetchWorkouts(String userId, String jwtToken);

  /// This function is used for fetching a single template entry.
  Future<Workout> fetchTemplate(int id, String jwtToken);

  /// This function is used for fetching a single workout entry.
  Future<Workout> fetchWorkout(int id, String jwtToken);

  /// This function is used for posting workout entries.
  Future<void> postWorkout(String coachNote, String note, String userId,
      String coachId, List<WorkoutSet> workoutSets, String completedOn, String createdOn, String name, String duration, bool isTemplate, String jwtToken);
}
