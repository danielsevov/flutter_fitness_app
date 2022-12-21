import 'workout_set.dart';

/// Entity class for holding details of a single Workout entry instance.
class Workout {
  String id; // id of the entry
  String coachId, // the id of the coach who created the workout
  userId, // the id of the user owner of the template
  coachNote, // the note from the coach
  completedOn, // the date of completion
  createdOn, // the date of creation
  name, // name of the workout
  duration; // the duration of the workout
  bool isTemplate; // indicator if this is a template or an actual workout
  List<WorkoutSet> sets; // list of all the workout sets in the workout

  // Simple constructor for creating an instance of an Workout entry
  Workout(this.id, this.name, this.coachNote, this.userId, this.coachId,
      this.isTemplate, this.completedOn, this.createdOn, this.duration, this.sets);

  // Function used for transforming a JSON to an Workout object.
  Workout.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        coachNote = json['coach_note'],
        name = json['workout_name'],
        userId = json['userId'],
        coachId = json['coachId'],
        completedOn = json['completed_on'],
        createdOn = json['created_on'],
        duration = json['duration'],
        isTemplate = json['is_template'],
        sets = List<WorkoutSet>.from(
            json["sets"].map((x) => WorkoutSet.fromJson(x)));

  // Function used for transforming a Workout entry object to JSON map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'coach_note': coachNote,
        'workout_name': name,
        'completed_on': completedOn,
        'created_on': createdOn,
        'duration': duration,
        'userId': userId,
        'coachId': coachId,
        'is_template': isTemplate,
        'sets': List<dynamic>.from(sets.map((x) => x.toJson())),
      };

  // Function used for transforming a Workout entry object to JSON map, excluding the id of the entry.
  Map<String, dynamic> toJsonNoID() => {
        'coach_note': coachNote,
        'workout_name': name,
        'completed_on': completedOn,
        'created_on': createdOn,
        'duration': duration,
        'userId': userId,
        'coachId': coachId,
        'is_template': isTemplate,
        'sets': List<dynamic>.from(sets.map((x) => x.toJson())),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Workout &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          coachId == other.coachId &&
          userId == other.userId &&
          coachNote == other.coachNote &&
          completedOn == other.completedOn &&
          createdOn == other.createdOn &&
          name == other.name &&
          duration == other.duration &&
          isTemplate == other.isTemplate;

  @override
  int get hashCode => int.parse(id) ^ id.hashCode ^ coachId.hashCode ^ isTemplate.hashCode;

  @override
  String toString() {
    return 'Workout{id: $id, coachId: $coachId, userId: $userId, coachNote: $coachNote, completedOn: $completedOn, createdOn: $createdOn, name: $name, duration: $duration, isTemplate: $isTemplate, sets: $sets}';
  }
}
