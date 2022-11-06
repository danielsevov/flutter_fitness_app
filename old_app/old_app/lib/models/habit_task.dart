import 'dart:collection';

class HabitTask {
  String task;
  bool isCompleted;

  HabitTask(this.task, this.isCompleted);

  HabitTask.fromJson(Map<String, dynamic> json)
      : task = json['task'],
        isCompleted = json['is_completed'];

  Map<String, dynamic> toJson() => {
    'task': task,
    'is_completed': isCompleted,
  };
}