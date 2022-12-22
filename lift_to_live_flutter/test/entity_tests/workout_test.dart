import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/entities/workout.dart';

import '../test_data.dart';

void main() {
  test('Workout constructor test', () {
    final workoutSet = TestData.testWorkout1;
    
    expect(workoutSet.name, 'A');
  });

  group('Workout fromJson tests', (){
    test('Workout fromJson compared to self', () {
      final workoutSet = TestData.testWorkout1;
      final workoutSetJson = workoutSet.toJson();

      expect(workoutSet == Workout.fromJson(workoutSetJson), true);
    });

    test('Workout fromJson compared to other Workout', () {
      final workoutSet = TestData.testWorkout1;
      final workoutSet2 = TestData.testWorkout2;
      final workoutSetJson = workoutSet2.toJson();

      expect(workoutSet == Workout.fromJson(workoutSetJson), false);
    });
  });

  group('Workout equals tests', (){
    test('Workout equals compared to self', () {
      final workoutSet = TestData.testWorkout1;

      expect(workoutSet == workoutSet, true);
    });

    test('Workout equals compared to self 2', () {
      final Workout workoutSet = TestData.testWorkout1;
      final workoutSet2 = Workout(1, 'A', 'A', 'A', 'A', false, 'A', 'A', 'A', [TestData.testWorkoutSet1]);

      expect(workoutSet == workoutSet2, true);
    });

    test('Workout equals compared to other Workout', () {
      final workoutSet = TestData.testWorkout1;
      final workoutSet2 = TestData.testWorkout2;

      expect(workoutSet == workoutSet2, false);
    });
  });

  group('Workout hashCode tests', (){
    test('Workout hashCode compared to self', () {
      final workoutSet = TestData.testWorkout1;

      expect(workoutSet.hashCode == workoutSet.hashCode, true);
    });

    test('Workout hashCode compared to self 2', () {
      final workoutSet = TestData.testWorkout1;
      final workoutSet2 = Workout(1, 'A', 'A', 'A', 'A', false, 'A', 'A', 'A', [TestData.testWorkoutSet1]);
      print('${workoutSet.hashCode} | ${workoutSet2.hashCode}');

      expect(workoutSet.hashCode == workoutSet2.hashCode, true);
    });

    test('Workout hashCode compared to other Workout', () {
      final workoutSet = TestData.testWorkout1;
      final workoutSet2 = TestData.testWorkout2;

      expect(workoutSet.hashCode == workoutSet2.hashCode, false);
    });
  });

  test('Workout toString', () {
    final workoutSet = TestData.testWorkout1;

    expect(workoutSet.toString(), 'Workout{id: 1, coachId: A, userId: A, coachNote: A, completedOn: A, createdOn: A, name: A, duration: A, isTemplate: false, sets: [\nWorkoutSet{setNote: A, reps: [1, 2, 3], kilos: [1, 2, 3], exercise: A, isCompleted: true}]}');
  });
}
