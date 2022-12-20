import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:lift_to_live_flutter/data/datasources/backend_api.dart';
import 'package:lift_to_live_flutter/data/exceptions/fetch_failed_exception.dart';
import 'package:lift_to_live_flutter/data/repositories/habits_repo_impl.dart';
import 'package:lift_to_live_flutter/domain/repositories/habits_repo.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'habits_repo_test.mocks.dart';

@GenerateMocks([BackendAPI])
void main() {

  group('fetch habits tests', () {
    test('returns response if the http call completes successfully', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchHabits('A', 'A')).thenAnswer((_) async => Response(
          '[{"id":9,"date":"1670407637607","habits":[{"task":"Eat one apple","is_completed":false},{"task":"Drink glass of milk","is_completed":false},{"task":"Do the laundry ","is_completed":false},{"task":"Deadlift 200 kilograms","is_completed":false}],"note":"This is my note","userId":"A","coachId":"B","is_template":false}]',
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      HabitsRepository repository = HabitsRepoImpl(backendAPI);

      var obj = await repository.fetchHabits('A', 'A');

      expect(obj.length, 1);
      expect(obj[0].id, 9);
      expect(obj[0].habits.length, 4);
    });

    test('throws an exception if the http call completes with an error',
            () async {
          final backendAPI = MockBackendAPI();

          when(backendAPI.fetchHabits('A', 'A')).thenAnswer((_) async => Response(
              '',
              404,
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }));

          HabitsRepository repository = HabitsRepoImpl(backendAPI);

          expect(() async => await repository.fetchHabits('A', 'A'),
              throwsA(isA<FailedFetchException>()));
        });
  });

  group('fetch template tests', () {
    test('returns response if the http call completes successfully', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchHabitTemplate('A', 'A')).thenAnswer((_) async => Response(
          '[{"id":9,"date":"1670407637607","habits":[{"task":"Eat one apple","is_completed":false},{"task":"Drink glass of milk","is_completed":false},{"task":"Do the laundry ","is_completed":false},{"task":"Deadlift 200 kilograms","is_completed":false}],"note":"This is my note","userId":"A","coachId":"B","is_template":true}]',
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      HabitsRepository repository = HabitsRepoImpl(backendAPI);

      var obj = await repository.fetchTemplate('A', 'A');

      expect(obj.id, 9);
      expect(obj.userId, 'A');
      expect(obj.habits.length, 4);
    });

    test('returns response if the http call completes successfully but no habits were found', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchHabitTemplate('A', 'A')).thenAnswer((_) async => Response(
          '[]',
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      HabitsRepository repository = HabitsRepoImpl(backendAPI);

      var obj = await repository.fetchTemplate('A', 'A');

      expect(obj.id, 0);
      expect(obj.userId, '');
      expect(obj.habits.length, 1);
    });

    test('throws an exception if the http call completes with an error',
            () async {
          final backendAPI = MockBackendAPI();

          when(backendAPI.fetchHabitTemplate('A', 'A')).thenAnswer((_) async => Response(
              '',
              404,
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }));

          HabitsRepository repository = HabitsRepoImpl(backendAPI);

          expect(() async => await repository.fetchTemplate('A', 'A'),
              throwsA(isA<FailedFetchException>()));
        });
  });

  group('post habit tests', () {
    test('if the http call completes successfully', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.postHabit('A', 'A', 'A', 'A', false, [], 'A')).thenAnswer((_) async => Response(
          '',
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      HabitsRepository repository = HabitsRepoImpl(backendAPI);

      expect(() async => await repository.postHabit('A', 'A', 'A', 'A', false, [], 'A'), returnsNormally);
    });

    test('throws an exception if the http call completes with an error',
            () async {
          final backendAPI = MockBackendAPI();

          when(backendAPI.postHabit('A', 'A', 'A', 'A', false, [], 'A')).thenThrow(FailedFetchException(''));

          HabitsRepository repository = HabitsRepoImpl(backendAPI);

          expect(() async => await repository.postHabit('A', 'A', 'A', 'A', false, [], 'A'), throwsA(isA<FailedFetchException>()));
        });
  });

  group('patch habit tests', () {
    test('if the http call completes successfully', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.patchHabit(1,'A', 'A', 'A', 'A', [], 'A')).thenAnswer((_) async => Response(
          '',
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      HabitsRepository repository = HabitsRepoImpl(backendAPI);

      expect(() async => await repository.patchHabit(1, 'A', 'A', 'A', 'A', [], 'A'), returnsNormally);
    });

    test('throws an exception if the http call completes with an error',
            () async {
          final backendAPI = MockBackendAPI();

          when(backendAPI.patchHabit(1, 'A', 'A', 'A', 'A', [], 'A')).thenThrow(FailedFetchException(''));

          HabitsRepository repository = HabitsRepoImpl(backendAPI);

          expect(() async => await repository.patchHabit(1, 'A', 'A', 'A', 'A', [], 'A'), throwsA(isA<FailedFetchException>()));
        });
  });
}
