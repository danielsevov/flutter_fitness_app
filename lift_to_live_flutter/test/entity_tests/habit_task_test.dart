import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/entities/habit_task.dart';

import '../test_data.dart';

void main() {
  test('HabitTask constructor test', () {
    final habit_task = TestData.test_habit_task_1;

    expect(habit_task.task, 'A');
    expect(habit_task.isCompleted, false);
  });

  group('HabitTask toJson tests', (){
    test('HabitTask toJson compared to self', () {
      final habit_task = TestData.test_habit_task_1;

      expect(habit_task.toJson().toString() == habit_task.toJson().toString(), true);
    });

    test('HabitTask toJson compared to self 2', () {
      final habit_task = TestData.test_habit_task_1;

      expect(habit_task.toJson().toString(), '{task: A, is_completed: false}');
    });

    test('HabitTask toJson compared to other', () {
      final habit_task = TestData.test_habit_task_1;
      final habit_task2 = TestData.test_habit_task_2;

      expect(habit_task.toJson().toString() == habit_task2.toJson().toString(), false);
    });
  });

  group('HabitTask fromJson tests', (){
    test('HabitTask fromJson compared to self', () {
      final habit_task = TestData.test_habit_task_1;
      final habit_taskJson = habit_task.toJson();

      expect(habit_task == HabitTask.fromJson(habit_taskJson), true);
    });

    test('HabitTask fromJson compared to other HabitTask', () {
      final habit_task = TestData.test_habit_task_1;
      final habit_task2 = TestData.test_habit_task_2;
      final habit_taskJson = habit_task2.toJson();

      expect(habit_task == HabitTask.fromJson(habit_taskJson), false);
    });
  });

  group('HabitTask equals tests', (){
    test('HabitTask equals compared to self', () {
      final habit_task = TestData.test_habit_task_1;

      expect(habit_task == habit_task, true);
    });

    test('HabitTask equals compared to self 2', () {
      final HabitTask habit_task = TestData.test_habit_task_1;
      final habit_task2 = HabitTask('A', false);

      expect(habit_task == habit_task2, true);
    });

    test('HabitTask equals compared to other HabitTask', () {
      final habit_task = TestData.test_habit_task_1;
      final habit_task2 = TestData.test_habit_task_2;

      expect(habit_task == habit_task2, false);
    });
  });

  group('HabitTask hashCode tests', (){
    test('HabitTask hashCode compared to self', () {
      final habit_task = TestData.test_habit_task_1;

      expect(habit_task.hashCode == habit_task.hashCode, true);
    });

    test('HabitTask hashCode compared to self 2', () {
      final habit_task = TestData.test_habit_task_1;
      final habit_task2 = HabitTask('A', false);

      expect(habit_task.hashCode == habit_task2.hashCode, true);
    });

    test('HabitTask hashCode compared to other HabitTask', () {
      final habit_task = TestData.test_habit_task_1;
      final habit_task2 = TestData.test_user_1;

      expect(habit_task.hashCode == habit_task2.hashCode, false);
    });
  });
}
