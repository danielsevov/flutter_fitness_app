import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/entities/workout_set.dart';

import '../test_data.dart';

void main() {
  test('WorkoutSet constructor test', () {
    final workoutSet = TestData.testWorkoutSet1;
    
    expect(workoutSet.exercise, 'A');
  });

  group('WorkoutSet fromJson tests', (){
    test('WorkoutSet fromJson compared to self', () {
      final workoutSet = TestData.testWorkoutSet1;
      final workoutSetJson = workoutSet.toJson();

      expect(workoutSet == WorkoutSet.fromJson(workoutSetJson), true);
    });

    test('WorkoutSet fromJson compared to other WorkoutSet', () {
      final workoutSet = TestData.testWorkoutSet1;
      final workoutSet2 = TestData.testWorkoutSet2;
      final workoutSetJson = workoutSet2.toJson();

      expect(workoutSet == WorkoutSet.fromJson(workoutSetJson), false);
    });
  });

  group('WorkoutSet equals tests', (){
    test('WorkoutSet equals compared to self', () {
      final workoutSet = TestData.testWorkoutSet1;

      expect(workoutSet == workoutSet, true);
    });

    test('WorkoutSet equals compared to self 2', () {
      final WorkoutSet workoutSet = TestData.testWorkoutSet1;
      final workoutSet2 = WorkoutSet('A', [1, 2, 3], [1, 2, 3], 'A', true);

      expect(workoutSet == workoutSet2, true);
    });

    test('WorkoutSet equals compared to other WorkoutSet', () {
      final workoutSet = TestData.testWorkoutSet1;
      final workoutSet2 = TestData.testWorkoutSet2;

      expect(workoutSet == workoutSet2, false);
    });
  });

  group('WorkoutSet hashCode tests', (){
    test('WorkoutSet hashCode compared to self', () {
      final workoutSet = TestData.testWorkoutSet1;

      expect(workoutSet.hashCode == workoutSet.hashCode, true);
    });

    test('WorkoutSet hashCode compared to self 2', () {
      final workoutSet = TestData.testWorkoutSet1;
      final workoutSet2 = WorkoutSet('A', [1, 2, 3], [1, 2, 3], 'A', true);

      expect(workoutSet.hashCode == workoutSet2.hashCode, true);
    });

    test('WorkoutSet hashCode compared to other WorkoutSet', () {
      final workoutSet = TestData.testWorkoutSet1;
      final workoutSet2 = TestData.testWorkoutSet2;

      expect(workoutSet.hashCode == workoutSet2.hashCode, false);
    });
  });

  test('WorkoutSet toString', () {
    final workoutSet = TestData.testWorkoutSet1;

    expect(workoutSet.toString(), '\nWorkoutSet{setNote: A, reps: [1, 2, 3], kilos: [1, 2, 3], exercise: A, isCompleted: true}');
  });
}
