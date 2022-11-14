import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:lift_to_live_flutter/data/datasources/backend_api.dart';
import 'package:lift_to_live_flutter/data/exceptions/fetch_failed_exception.dart';
import 'package:lift_to_live_flutter/data/repositories/user_repo_impl.dart';
import 'package:lift_to_live_flutter/domain/repositories/user_repo.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_data.dart';
import 'user_repo_test.mocks.dart';

@GenerateMocks([BackendAPI])
void main() {
  group('mock test user repository to fetch user', () {
    test('returns response if the http call completes successfully', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchUser('A', 'A')).thenAnswer(
          (_) async => Response('{"id": "user@email.com", "name": "Test User", "email": "user@email.com", "coach_id": "coach@email.com", "nationality": "NL", "date_of_birth": "23/12/1999", "phone_number": "5555555555"}', 200, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      UserRepository repository = UserRepoImpl(backendAPI);

      expect(await repository.fetchUser('A', 'A'), TestData.test_user_1);
    });

    test('throws an exception if the http call completes with an error', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchUser('A', 'A')).thenAnswer(
              (_) async => Response('', 404, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      UserRepository repository = UserRepoImpl(backendAPI);

      expect(() async => await repository.fetchUser('A', 'A'), throwsA(isA<FetchFailedException>()));
    });
  });

  group('mock test user repository to fetch profile image', () {
    test('returns response if the http call completes successfully', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchProfileImage('A', 'A')).thenAnswer(
              (_) async => Response('[{"user_id": "A", "type": "A", "id": 1, "date": "A", "data": "4444"}]', 200, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      UserRepository repository = UserRepoImpl(backendAPI);

      expect(await repository.fetchProfileImage('A', 'A'), isA<Image>());
    });

    test('throws an exception if the http call completes with an error', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchProfileImage('A', 'A')).thenAnswer(
              (_) async => Response('', 404, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      UserRepository repository = UserRepoImpl(backendAPI);

      expect(() async => await repository.fetchProfileImage('A', 'A'), throwsA(isA<FetchFailedException>()));
    });
  });

  group('mock test user repository to fetch user roles', () {
    test('returns response if the http call completes successfully', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchUserRoles('A')).thenAnswer(
              (_) async => Response('[{"userId": "A", "name": "A"}]', 200, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      UserRepository repository = UserRepoImpl(backendAPI);

      expect(await repository.fetchUserRoles('A'), [TestData.test_role_1]);
    });

    test('throws an exception if the http call completes with an error', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchUserRoles('A')).thenAnswer(
              (_) async => Response('', 404, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      UserRepository repository = UserRepoImpl(backendAPI);

      expect(() async => await repository.fetchUserRoles('A'), throwsA(isA<FetchFailedException>()));
    });
  });
}
