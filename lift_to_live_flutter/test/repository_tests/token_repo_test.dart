import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:lift_to_live_flutter/data/datasources/backend_api.dart';
import 'package:lift_to_live_flutter/data/exceptions/fetch_failed_exception.dart';
import 'package:lift_to_live_flutter/data/repositories/token_repo_impl.dart';
import 'package:lift_to_live_flutter/domain/repositories/token_repo.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../mock_data.dart';
import 'token_repo_test.mocks.dart';

@GenerateMocks([BackendAPI])
void main() {
  group('mock test token repository to fetch JWT token', () {
    test('returns response if the http call completes successfully', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.logIn('email', 'password')).thenAnswer(
          (_) async => Response('{"token": "A"}', 200, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      TokenRepository repository = TokenRepoImpl(backendAPI);

      expect(await repository.getToken('email', 'password'), MockData.testToken1.token);
    });

    test('throws an exception if the http call completes with an error', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.logIn('email', 'password')).thenAnswer(
              (_) async => Response('', 404, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      TokenRepository repository = TokenRepoImpl(backendAPI);

      expect(() async => await repository.getToken('email', 'password'), throwsA(isA<FailedFetchException>()));
    });
  });
}
