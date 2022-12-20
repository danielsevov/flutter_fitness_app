import 'package:lift_to_live_flutter/domain/entities/exercise.dart';

/// API to the Exercise repository object.
/// Defines methods to be implemented.
abstract class ExerciseRepository {
  /// This function is used for fetching a list of all Exercise objects.
  Future<List<Exercise>> getExercises();
}
