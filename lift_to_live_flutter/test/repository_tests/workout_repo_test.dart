import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:lift_to_live_flutter/data/datasources/backend_api.dart';
import 'package:lift_to_live_flutter/data/exceptions/fetch_failed_exception.dart';
import 'package:lift_to_live_flutter/data/repositories/workout_repo_impl.dart';
import 'package:lift_to_live_flutter/domain/repositories/workout_repo.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'workout_repo_test.mocks.dart';

@GenerateMocks([BackendAPI])
void main() {

  group('fetch workouts tests', () {
    test('returns response if the http call completes successfully', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchWorkouts('A', 'A')).thenAnswer((_) async => Response(
          '[{"sets":[{"set_note":"A","reps":["10","10"],"kilos":["10","10"],"exercise":"A","is_completed":false},{"set_note":"A","reps":["10","10"],"kilos":["10","10"],"exercise":"A","is_completed":false},{"set_note":"A ","reps":["10","10"],"kilos":["10","10"],"exercise":"A","is_completed":false}],"id":1,"coachId":"A","userId":"A","coach_note":"A","completed_on":"A","workout_name":"A","created_on":"A","is_template":false,"duration":"0"}]',
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      WorkoutRepository repository = WorkoutRepoImpl(backendAPI);

      var obj = await repository.fetchWorkouts('A', 'A');

      expect(obj.length, 1);
      expect(obj[0].id, 1);
      expect(obj[0].sets.length, 3);
    });

    test('returns response if the http call completes successfully but list is empty', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchWorkouts('A', 'A')).thenAnswer((_) async => Response(
          '[]',
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      WorkoutRepository repository = WorkoutRepoImpl(backendAPI);

      expect(() async => await repository.fetchWorkouts('A', 'A'),
          throwsA(isA<FailedFetchException>()));
    });

    test('throws an exception if the http call completes with an error',
            () async {
          final backendAPI = MockBackendAPI();

          when(backendAPI.fetchWorkouts('A', 'A')).thenAnswer((_) async => Response(
              '',
              404,
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }));

          WorkoutRepository repository = WorkoutRepoImpl(backendAPI);

          expect(() async => await repository.fetchWorkouts('A', 'A'),
              throwsA(isA<FailedFetchException>()));
        });
  });

  group('fetch template tests', () {
    test('returns response if the http call completes successfully', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchWorkoutTemplates('A', 'A')).thenAnswer((_) async => Response(
          '[{"sets":[{"set_note":"A","reps":["10","10"],"kilos":["10","10"],"exercise":"A","is_completed":false},{"set_note":"A","reps":["10","10"],"kilos":["10","10"],"exercise":"A","is_completed":false},{"set_note":"A ","reps":["10","10"],"kilos":["10","10"],"exercise":"A","is_completed":false}],"id":1,"coachId":"A","userId":"A","coach_note":"A","completed_on":"A","workout_name":"A","created_on":"A","is_template":true,"duration":"0"}]',
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      WorkoutRepository repository = WorkoutRepoImpl(backendAPI);

      var obj = await repository.fetchTemplates('A', 'A');

      expect(obj[0].id, 1);
      expect(obj[0].userId, 'A');
      expect(obj[0].sets.length, 3);
    });

    test('returns response if the http call completes successfully but list is empty', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchWorkoutTemplates('A', 'A')).thenAnswer((_) async => Response(
          '[]',
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      WorkoutRepository repository = WorkoutRepoImpl(backendAPI);

      expect(() async => await repository.fetchTemplates('A', 'A'),
          throwsA(isA<FailedFetchException>()));
    });

    test('throws an exception if the http call completes with an error',
            () async {
          final backendAPI = MockBackendAPI();

          when(backendAPI.fetchWorkoutTemplates('A', 'A')).thenAnswer((_) async => Response(
              '',
              404,
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }));

          WorkoutRepository repository = WorkoutRepoImpl(backendAPI);

          expect(() async => await repository.fetchTemplates('A', 'A'),
              throwsA(isA<FailedFetchException>()));
        });
  });

  group('fetch single workout tests', () {
    test('returns response if the http call completes successfully', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchWorkout(1, 'A')).thenAnswer((_) async => Response(
          '{"sets":[{"set_note":"A","reps":["10","10"],"kilos":["10","10"],"exercise":"A","is_completed":false},{"set_note":"A","reps":["10","10"],"kilos":["10","10"],"exercise":"A","is_completed":false},{"set_note":"A ","reps":["10","10"],"kilos":["10","10"],"exercise":"A","is_completed":false}],"id":1,"coachId":"A","userId":"A","coach_note":"A","completed_on":"A","workout_name":"A","created_on":"A","is_template":true,"duration":"0"}',
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      WorkoutRepository repository = WorkoutRepoImpl(backendAPI);

      var obj = await repository.fetchWorkout(1, 'A');

      expect(obj.id, 1);
      expect(obj.userId, 'A');
      expect(obj.sets.length, 3);
    });

    test('throws an exception if the http call completes with an error',
            () async {
          final backendAPI = MockBackendAPI();

          when(backendAPI.fetchWorkout(1, 'A')).thenAnswer((_) async => Response(
              '',
              404,
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }));

          WorkoutRepository repository = WorkoutRepoImpl(backendAPI);

          expect(() async => await repository.fetchWorkout(1, 'A'),
              throwsA(isA<FailedFetchException>()));
        });
  });

  group('fetch single template tests', () {
    test('returns response if the http call completes successfully', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchWorkout(1, 'A')).thenAnswer((_) async => Response(
          '{"sets":[{"set_note":"A","reps":["10","10"],"kilos":["10","10"],"exercise":"A","is_completed":false},{"set_note":"A","reps":["10","10"],"kilos":["10","10"],"exercise":"A","is_completed":false},{"set_note":"A ","reps":["10","10"],"kilos":["10","10"],"exercise":"A","is_completed":false}],"id":1,"coachId":"A","userId":"A","coach_note":"A","completed_on":"A","workout_name":"A","created_on":"A","is_template":true,"duration":"0"}',
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      WorkoutRepository repository = WorkoutRepoImpl(backendAPI);

      var obj = await repository.fetchTemplate(1, 'A');

      expect(obj.id, 1);
      expect(obj.userId, 'A');
      expect(obj.sets.length, 3);
    });

    test('returns response if the template id is 0', () async {
      final backendAPI = MockBackendAPI();

      WorkoutRepository repository = WorkoutRepoImpl(backendAPI);

      var obj = await repository.fetchTemplate(0, 'A');

      expect(obj.id, 0);
      expect(obj.userId, '');
      expect(obj.sets.length, 0);
    });

    test('throws an exception if the http call completes with an error',
            () async {
          final backendAPI = MockBackendAPI();

          when(backendAPI.fetchWorkout(1, 'A')).thenAnswer((_) async => Response(
              '',
              404,
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }));

          WorkoutRepository repository = WorkoutRepoImpl(backendAPI);

          expect(() async => await repository.fetchTemplate(1, 'A'),
              throwsA(isA<FailedFetchException>()));
        });
  });

  group('post workout tests', () {
    test('if the http call completes successfully', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.postWorkout(any, any, any, any, any, any, any, any, any, any, any)).thenAnswer((_) async => Response(
          '',
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      WorkoutRepository repository = WorkoutRepoImpl(backendAPI);

      expect(() async => await repository.postWorkout('A', 'A', 'A', 'A', [], 'A', 'A', 'A', 'A', true, 'A'), returnsNormally);
    });

    test('throws an exception if the http call completes with an error',
            () async {
          final backendAPI = MockBackendAPI();

          when(backendAPI.postWorkout(any, any, any, any, any, any, any, any, any, any, any)).thenThrow(FailedFetchException(''));

          WorkoutRepository repository = WorkoutRepoImpl(backendAPI);

          expect(() async => await repository.postWorkout('A', 'A', 'A', 'A', [], 'A', 'A', 'A', 'A', true, 'A'), throwsA(isA<FailedFetchException>()));
        });
  });

  group('patch workout tests', () {
    test('if the http call completes successfully', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.patchWorkout(1,any, any, any, any, any, any, any, any, any, any, any)).thenAnswer((_) async => Response(
          '',
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      WorkoutRepository repository = WorkoutRepoImpl(backendAPI);

      expect(() async => await repository.patchWorkout(1, 'A', 'A', 'A', 'A', [], 'A', 'A', 'A', 'A', true, 'A'), returnsNormally);
    });

    test('throws an exception if the http call completes with an error',
            () async {
          final backendAPI = MockBackendAPI();

          when(backendAPI.patchWorkout(1, any, any, any, any, any, any, any, any, any, any, any)).thenThrow(FailedFetchException(''));

          WorkoutRepository repository = WorkoutRepoImpl(backendAPI);

          expect(() async => await repository.patchWorkout(1, 'A', 'A', 'A', 'A', [], 'A', 'A', 'A', 'A', true, 'A'), throwsA(isA<FailedFetchException>()));
        });
  });

  group('delete workout tests', () {
    test('if the http call completes successfully', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.deleteWorkout(1, any)).thenAnswer((_) async => Response(
          '',
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      WorkoutRepository repository = WorkoutRepoImpl(backendAPI);

      expect(() async => await repository.deleteWorkout(1, 'A',), returnsNormally);
    });

    test('if the http call completes successfully', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.deleteWorkout(1, any)).thenAnswer((_) async => Response(
          '',
          204,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      WorkoutRepository repository = WorkoutRepoImpl(backendAPI);

      expect(() async => await repository.deleteWorkout(1, 'A',), returnsNormally);
    });

    test('if the http call completes successfully', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.deleteWorkout(1, any)).thenAnswer((_) async => Response(
          '',
          404,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      WorkoutRepository repository = WorkoutRepoImpl(backendAPI);

      expect(() async => await repository.deleteWorkout(1, 'A'), throwsA(isA<FailedFetchException>()));
    });

    test('throws an exception if the http call completes with an error',
            () async {
          final backendAPI = MockBackendAPI();

          when(backendAPI.deleteWorkout(1, any)).thenThrow(FailedFetchException(''));

          WorkoutRepository repository = WorkoutRepoImpl(backendAPI);

          expect(() async => await repository.deleteWorkout(1, 'A'), throwsA(isA<FailedFetchException>()));
        });
  });
}
