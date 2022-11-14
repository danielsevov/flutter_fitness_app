import 'habit_task.dart';

/// Entity class for holding details of a single Habit entry instance.
class Habit {
  int id; // id of the entry
  String date, // date of the entry
      note, // note by the trainee
      userId, // the id of the trainee
      coachId; // the id of the coach of the trainee
  bool isTemplate; // indicator if this is a template or an actual entry
  List<HabitTask> habits; // list of all the habit tasks in the entry

  // Simple constructor for creating an instance of an Habit entry
  Habit(this.id, this.date, this.note, this.userId, this.coachId,
      this.isTemplate, this.habits);

  // Function used for transforming a JSON to an Habit object.
  Habit.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = json['date'],
        note = json['note'],
        userId = json['userId'],
        coachId = json['coachId'],
        isTemplate = json['is_template'],
        habits = List<HabitTask>.from(
            json["habits"].map((x) => HabitTask.fromJson(x)));

  // Function used for transforming a Habit entry object to JSON map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'note': note,
        'userId': userId,
        'coachId': coachId,
        'is_template': isTemplate,
        'habits': List<dynamic>.from(habits.map((x) => x.toJson())),
      };

  // Function used for transforming a Habit entry object to JSON map, excluding the id of the entry.
  Map<String, dynamic> toJsonNoID() => {
        'date': date,
        'note': note,
        'userId': userId,
        'coachId': coachId,
        'is_template': isTemplate,
        'habits': List<dynamic>.from(habits.map((x) => x.toJson())),
      };

  //Equals function
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Habit &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          date == other.date &&
          note == other.note &&
          userId == other.userId &&
          coachId == other.coachId &&
          isTemplate == other.isTemplate &&
          habits == other.habits;

  //Hashcode function
  @override
  int get hashCode =>
      id.hashCode ^
      date.hashCode ^
      note.hashCode ^
      userId.hashCode ^
      coachId.hashCode ^
      isTemplate.hashCode ^
      habits.hashCode;
}
