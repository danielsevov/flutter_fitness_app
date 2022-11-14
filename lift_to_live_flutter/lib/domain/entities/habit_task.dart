/// Entity class for holding details of a single Habit task instance.
class HabitTask {
  String task; // Task description
  bool isCompleted; // Indicator of completeness of the task

  // Simple constructor for creating a habit task instance
  HabitTask(this.task, this.isCompleted);

  // Function used for transforming a JSON to an Habit Task object.
  HabitTask.fromJson(Map<String, dynamic> json)
      : task = json['task'],
        isCompleted = json['is_completed'];

  // Function used for transforming a Habit task object to JSON map.
  Map<String, dynamic> toJson() => {
        'task': task,
        'is_completed': isCompleted,
      };

  //Equals function
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitTask &&
          runtimeType == other.runtimeType &&
          task == other.task &&
          isCompleted == other.isCompleted;

  //Hashcode function
  @override
  int get hashCode => task.hashCode ^ isCompleted.hashCode;
}
