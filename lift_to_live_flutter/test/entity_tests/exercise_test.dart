import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/entities/exercise.dart';

import '../mock_data.dart';

void main() {
  test('Exercise constructor test', () {
    final exercise = MockData.testExercise1;
    
    expect(exercise.name, 'A');
  });

  group('Exercise fromJson tests', (){
    test('Exercise fromJson compared to self', () {
      final exercise = MockData.testExercise1;
      final exerciseJson = exercise.toJson();

      expect(exercise == Exercise.fromJson(exerciseJson), true);
    });

    test('Exercise fromJson compared to other Exercise', () {
      final exercise = MockData.testExercise1;
      final exercise2 = MockData.testExercise2;
      final exerciseJson = exercise2.toJson();

      expect(exercise == Exercise.fromJson(exerciseJson), false);
    });
  });

  group('Exercise equals tests', (){
    test('Exercise equals compared to self', () {
      final exercise = MockData.testExercise1;

      expect(exercise == exercise, true);
    });

    test('Exercise equals compared to self 2', () {
      final Exercise exercise = MockData.testExercise1;
      final exercise2 = Exercise('A', 'A', 'A', 'A', 'A');

      expect(exercise == exercise2, true);
    });

    test('Exercise equals compared to other Exercise', () {
      final exercise = MockData.testExercise1;
      final exercise2 = MockData.testExercise2;

      expect(exercise == exercise2, false);
    });
  });

  group('Exercise hashCode tests', (){
    test('Exercise hashCode compared to self', () {
      final exercise = MockData.testExercise1;

      expect(exercise.hashCode == exercise.hashCode, true);
    });

    test('Exercise hashCode compared to self 2', () {
      final exercise = MockData.testExercise1;
      final exercise2 = Exercise('A', 'A', 'A', 'A', 'A');

      expect(exercise.hashCode == exercise2.hashCode, true);
    });

    test('Exercise hashCode compared to other Exercise', () {
      final exercise = MockData.testExercise1;
      final exercise2 = MockData.testUser1;

      expect(exercise.hashCode == exercise2.hashCode, false);
    });
  });
}
