import '../../helper.dart';

/// Entity class for holding details of a single workout set.
class WorkoutSet {
  String setNote; // Set note by the coach
  List<int> reps; // List of all repetition values
  List<int> kilos; // List of all kilogram values
  String exercise; // Name of the exercise
  bool isCompleted; // Indicator if set is completed

  // Simple constructor for creating a workout set instance
  WorkoutSet(this.setNote, this.reps, this.kilos, this.exercise, this.isCompleted);

  // Function used for transforming a JSON to a workout set object.
  WorkoutSet.fromJson(Map<String, dynamic> json)
      : setNote = json['set_note'],
        reps = Helper.toIntList(json['reps']),
        kilos = Helper.toIntList(json['kilos']),
        exercise = json['exercise'],
        isCompleted = json['is_completed'];

  // Function used for transforming a workout set object to JSON map.
  Map<String, dynamic> toJson() => {
        'set_note': setNote,
        'reps': reps,
        'kilos': kilos,
        'exercise': exercise,
        'is_completed': isCompleted,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutSet &&
          runtimeType == other.runtimeType &&
          setNote == other.setNote &&
          reps == other.reps &&
          kilos == other.kilos &&
          exercise == other.exercise &&
          isCompleted == other.isCompleted;

  @override
  int get hashCode =>
      setNote.hashCode ^
      reps.hashCode ^
      kilos.hashCode ^
      exercise.hashCode ^
      isCompleted.hashCode;

  @override
  String toString() {
    return '\nWorkoutSet{setNote: $setNote, reps: $reps, kilos: $kilos, exercise: $exercise, isCompleted: $isCompleted}';
  }
}
