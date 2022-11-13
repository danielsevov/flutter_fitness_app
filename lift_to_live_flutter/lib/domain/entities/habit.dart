import 'habit_task.dart';

class Habit {
  int id;
  String date, note, userId, coachId;
  bool isTemplate;
  List<HabitTask> habits;

  Habit(this.id, this.date, this.note, this.userId, this.coachId, this.isTemplate, this.habits);

  Habit.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = json['date'],
        note = json['note'],
        userId = json['userId'],
        coachId = json['coachId'],
        isTemplate = json['is_template'],
        habits = List<HabitTask>.from(
            json["habits"]
                .map((x) => HabitTask.fromJson(x)));

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date,
    'note': note,
    'userId': userId,
    'coachId': coachId,
    'is_template': isTemplate,
    'habits': List<dynamic>.from(habits.map((x) => x.toJson())),
  };

  Map<String, dynamic> toJsonNoID() => {
    'date': date,
    'note': note,
    'userId': userId,
    'coachId': coachId,
    'is_template': isTemplate,
    'habits': List<dynamic>.from(habits.map((x) => x.toJson())),
  };

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