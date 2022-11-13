import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/entities/habit.dart';

import '../test_data.dart';

void main() {
  test('Habit constructor test', () {
    final habit = TestData.test_habit_1;

    expect(habit.userId, 'A');
    expect(habit.id, 1);
    expect(habit.date, 'A');
    expect(habit.habits, [TestData.test_habit_task_1, TestData.test_habit_task_2, TestData.test_habit_task_3]);
    expect(habit.isTemplate, false);
    expect(habit.note, 'A');
    expect(habit.coachId, 'A');
  });

  group('Habit toJson tests', (){
    test('Habit toJson compared to self', () {
      final habit = TestData.test_habit_1;

      expect(habit.toJson().toString() == habit.toJson().toString(), true);
    });

    test('Habit toJson compared to self 2', () {
      final habit = TestData.test_habit_1;

      expect(habit.toJson().toString(), '{id: 1, date: A, note: A, userId: A, coachId: A, is_template: false, habits: [{task: A, is_completed: false}, {task: B, is_completed: false}, {task: C, is_completed: false}]}');
    });

    test('Habit toJsonNoID compared to self', () {
      final habit = TestData.test_habit_1;

      expect(habit.toJsonNoID().toString(), '{date: A, note: A, userId: A, coachId: A, is_template: false, habits: [{task: A, is_completed: false}, {task: B, is_completed: false}, {task: C, is_completed: false}]}');
    });

    test('Habit toJson compared to other', () {
      final habit = TestData.test_habit_1;
      final habit2 = TestData.test_habit_2;

      expect(habit.toJson().toString() == habit2.toJson().toString(), false);
    });
  });

  group('Habit fromJson tests', (){
    test('Habit fromJson compared to self', () {
      final habit = TestData.test_habit_1;
      final habitJson = habit.toJson();

      expect(habit.toString() == Habit.fromJson(habitJson).toString(), true);
    });

    test('Habit fromJson compared to other Habit', () {
      final habit = TestData.test_habit_1;
      final habit2 = TestData.test_habit_2;
      final habitJson = habit2.toJson();

      expect(habit == Habit.fromJson(habitJson), false);
    });
  });

  group('Habit equals tests', (){
    test('Habit equals compared to self', () {
      final habit = TestData.test_habit_1;

      expect(habit == habit, true);
    });

    test('Habit equals compared to self 2', () {
      final Habit habit = TestData.test_habit_1;
      final habit2 = Habit(1, 'A', 'A', 'A', 'A', false, TestData.test_list_tasks_1);

      expect(habit == habit2, true);
    });

    test('Habit equals compared to other Habit', () {
      final habit = TestData.test_habit_1;
      final habit2 = TestData.test_habit_2;

      expect(habit == habit2, false);
    });
  });

  group('Habit hashCode tests', (){
    test('Habit hashCode compared to self', () {
      final habit = TestData.test_habit_1;

      expect(habit.hashCode == habit.hashCode, true);
    });

    test('Habit hashCode compared to self 2', () {
      final habit = TestData.test_habit_1;
      final habit2 = Habit(1, 'A', 'A', 'A', 'A', false, TestData.test_list_tasks_1);

      expect(habit.hashCode == habit2.hashCode, true);
    });

    test('Habit hashCode compared to other Habit', () {
      final habit = TestData.test_habit_1;
      final habit2 = TestData.test_user_1;

      expect(habit.hashCode == habit2.hashCode, false);
    });
  });
}
