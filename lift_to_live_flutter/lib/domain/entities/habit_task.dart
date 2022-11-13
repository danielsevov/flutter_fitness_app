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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitTask &&
          runtimeType == other.runtimeType &&
          task == other.task &&
          isCompleted == other.isCompleted;

  @override
  int get hashCode => task.hashCode ^ isCompleted.hashCode;
}