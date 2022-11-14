import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:lift_to_live_flutter/data/datasources/news_api.dart';
import 'package:lift_to_live_flutter/data/exceptions/fetch_failed_exception.dart';
import 'package:lift_to_live_flutter/data/repositories/news_repo_impl.dart';
import 'package:lift_to_live_flutter/domain/repositories/news_repo.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_data.dart';
import 'news_repo_test.mocks.dart';

@GenerateMocks([NewsAPI])
void main() {
  group('mock test news repository to fetch news', () {
    test('returns response if the http call completes successfully', () async {
      final newsAPI = MockNewsAPI();

      when(newsAPI.fetchNews('search', 1)).thenAnswer(
          (_) async => Response('{"status": "A", "totalResults": 1, "articles": [{"author": "A", "title": "A", "description": "A", "url": "A", "urlToImage": "A", "content": "A"}]}', 200, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      NewsRepository repository = NewsRepoImpl(newsAPI);

      expect(await repository.getNews("search", 1), TestData.test_news_1);
    });

    test('throws an exception if the http call completes with an error', () async {
      final backendAPI = MockNewsAPI();

      when(backendAPI.fetchNews('search', 1)).thenAnswer(
              (_) async => Response('', 404, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          }));

      NewsRepository repository = NewsRepoImpl(backendAPI);

      expect(() async => await repository.getNews("search", 1), throwsA(isA<FetchFailedException>()));
    });
  });
}
