import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:lift_to_live_flutter/data/datasources/backend_api.dart';
import 'package:lift_to_live_flutter/data/exceptions/duplicated_id_exception.dart';
import 'package:lift_to_live_flutter/data/exceptions/fetch_failed_exception.dart';
import 'package:lift_to_live_flutter/data/repositories/user_repo_impl.dart';
import 'package:lift_to_live_flutter/domain/entities/image.dart';
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

      expect(await repository.fetchUser('A', 'A'), TestData.testUser1);
    });

    test('throws an exception if the http call completes with an error', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchUser('A', 'A')).thenAnswer(
              (_) async => Response('', 404, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      UserRepository repository = UserRepoImpl(backendAPI);

      expect(() async => await repository.fetchUser('A', 'A'), throwsA(isA<FailedFetchException>()));
    });
  });

  group('mock test user repository to fetch my trainees', () {
    test('returns response if the http call completes successfully', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchMyTrainees('A')).thenAnswer(
              (_) async => Response('[{"id": "user@email.com", "name": "Test User", "email": "user@email.com", "coach_id": "coach@email.com", "nationality": "NL", "date_of_birth": "23/12/1999", "phone_number": "5555555555"}]', 200, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      UserRepository repository = UserRepoImpl(backendAPI);

      expect(await repository.fetchMyTrainees('A', 'A'), [TestData.testUser1]);
    });

    test('throws an exception if the http call completes with an error', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchMyTrainees('A')).thenAnswer(
              (_) async => Response('', 404, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      UserRepository repository = UserRepoImpl(backendAPI);

      expect(() async => await repository.fetchMyTrainees('A', 'A'), throwsA(isA<FailedFetchException>()));
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

      expect(await repository.fetchProfileImage('A', 'A'), isA<MyImage>());
    });

    test('throws an exception if the http call completes with an error', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchProfileImage('A', 'A')).thenAnswer(
              (_) async => Response('', 404, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      UserRepository repository = UserRepoImpl(backendAPI);

      expect(() async => await repository.fetchProfileImage('A', 'A'), throwsA(isA<FailedFetchException>()));
    });
  });

  test('test post image', () async {
    final backendAPI = MockBackendAPI();

    when(backendAPI.postImage('', '', '', '', '')).thenAnswer((realInvocation) async => Response('', 200, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    }));

    UserRepository repository = UserRepoImpl(backendAPI);

    expect(() => repository.postImage('', '', '', '', ''), returnsNormally);
  });

  test('test post image fail', () async {
    final backendAPI = MockBackendAPI();

    when(backendAPI.postImage('', '', '', '', '')).thenAnswer((realInvocation) async => Response('', 404, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    }));

    UserRepository repository = UserRepoImpl(backendAPI);

    expect(() => repository.postImage('', '', '', '', ''), throwsException);
  });

  test('test delete image', () async {
    final backendAPI = MockBackendAPI();

    when(backendAPI.deleteImage( 1 ,'')).thenAnswer((realInvocation) async => Response('', 200, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    }));

    UserRepository repository = UserRepoImpl(backendAPI);

    expect(() => repository.deleteImage( 1 ,''), returnsNormally);
  });

  test('test delete image fail', () async {
    final backendAPI = MockBackendAPI();

    when(backendAPI.deleteImage( 1 ,'')).thenAnswer((realInvocation) async => Response('', 404, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    }));

    UserRepository repository = UserRepoImpl(backendAPI);

    expect(() => repository.deleteImage( 1 ,''), throwsException);
  });

  test('test delete image exception', () async {
    final backendAPI = MockBackendAPI();

    when(backendAPI.deleteImage( 1 ,'')).thenThrow(FailedFetchException(''));

    UserRepository repository = UserRepoImpl(backendAPI);

    expect(() => repository.deleteImage( 1 ,''), throwsA(isA<FailedFetchException>()));
  });

  test('test patch image', () async {
    final backendAPI = MockBackendAPI();

    when(backendAPI.patchImage(1 ,'', '', '', '', '')).thenAnswer((realInvocation) async => Response('', 200, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    }));

    UserRepository repository = UserRepoImpl(backendAPI);

    expect(() async => repository.patchImage(1, '', '', '', '', ''), returnsNormally);
  });

  test('test patch image', () async {
    final backendAPI = MockBackendAPI();

    when(backendAPI.patchImage(1 ,'', '', '', '', '')).thenAnswer((realInvocation) async => Response('', 404, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    }));

    UserRepository repository = UserRepoImpl(backendAPI);

    expect(() async => repository.patchImage(1, '', '', '', '', ''), throwsException);
  });

  test('test get images', () async {
    final backendAPI = MockBackendAPI();

    when(backendAPI.fetchImages(any, any)).thenAnswer((realInvocation) async => Response('[{"user_id": "A", "type": "A", "id": 1, "date": "A", "data": "4444"}]', 200, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    }));

    UserRepository repository = UserRepoImpl(backendAPI);

    expect(await repository.fetchUserImages('A', 'A'), isA<List<MyImage>>());
  });

  test('test get images with exception', () async {
    final backendAPI = MockBackendAPI();

    when(backendAPI.fetchImages(any, any)).thenAnswer(
            (_) async => Response('', 404, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        }));

    UserRepository repository = UserRepoImpl(backendAPI);

    expect(() async => await repository.fetchUserImages('A', 'A'), throwsA(isA<FailedFetchException>()));
  });

  group('mock test user repository to fetch user roles', () {
    test('returns response if the http call completes successfully', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchUserRoles('A')).thenAnswer(
              (_) async => Response('[{"userId": "A", "name": "A"}]', 200, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      UserRepository repository = UserRepoImpl(backendAPI);

      expect(await repository.fetchUserRoles('A'), [TestData.testRole1]);
    });

    test('throws an exception if the http call completes with an error', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchUserRoles('A')).thenAnswer(
              (_) async => Response('', 404, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      UserRepository repository = UserRepoImpl(backendAPI);

      expect(() async => await repository.fetchUserRoles('A'), throwsA(isA<FailedFetchException>()));
    });
  });

  group('mock test user repository to fetch coach roles', () {
    test('returns response if the http call completes successfully', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchCoachRoles('A')).thenAnswer(
              (_) async => Response('[{"userId": "A", "name": "A"}]', 200, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      UserRepository repository = UserRepoImpl(backendAPI);

      expect(await repository.fetchCoachRoles('A'), [TestData.testRole1]);
    });

    test('throws an exception if the http call completes with an error', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.fetchCoachRoles('A')).thenAnswer(
              (_) async => Response('', 404, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      UserRepository repository = UserRepoImpl(backendAPI);

      expect(() async => await repository.fetchCoachRoles('A'), throwsA(isA<FailedFetchException>()));
    });
  });

  group('mock test user repository to register user', () {
    test('returns response if the http call completes successfully 200', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.registerUser(any, any, any, any, any, any, any, any)).thenAnswer(
              (_) async => Response('', 200, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      UserRepository repository = UserRepoImpl(backendAPI);

      expect(() async => await repository.registerUser('', '', '', '', '', '', '', ''), returnsNormally);
    });

    test('throws an exception if the http call completes with an error 409', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.registerUser(any, any, any, any, any, any, any, any)).thenAnswer(
              (_) async => Response('', 409, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      UserRepository repository = UserRepoImpl(backendAPI);

      expect(() async =>  await repository.registerUser('', '', '', '', '', '', '', ''), throwsA(isA<DuplicatedIdException>()));
    });

    test('throws an exception if the http call completes with an error 404', () async {
      final backendAPI = MockBackendAPI();

      when(backendAPI.registerUser(any, any, any, any, any, any, any, any)).thenAnswer(
              (_) async => Response('', 404, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      UserRepository repository = UserRepoImpl(backendAPI);

      expect(() async =>  await repository.registerUser('', '', '', '', '', '', '', ''), throwsA(isA<FailedFetchException>()));
    });
  });
}