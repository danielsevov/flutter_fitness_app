import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/entities/news.dart';

import '../test_data.dart';

void main() {
  test('News constructor test', () {
    final news = TestData.testNews1;

    expect(news.articles, [TestData.testArticle1]);
    expect(news.status, 'A');
    expect(news.totalResults, 1);
  });

  group('News toJson tests', (){
    test('News toJson compared to self', () {
      final news = TestData.testNews1;

      expect(news.toJson().toString() == news.toJson().toString(), true);
    });

    test('News toJson compared to self 2', () {
      final news = TestData.testNews1;

      expect(news.toJson().toString(), '{status: A, totalResults: 1, articles: [{author: A, title: A, description: A, url: A, urlToImage: A, content: A}]}');
    });

    test('News toJson compared to other', () {
      final news = TestData.testNews1;
      final news2 = TestData.testNews2;

      expect(news.toJson().toString() == news2.toJson().toString(), false);
    });
  });

  group('News fromJson tests', (){
    test('News fromJson compared to self', () {
      final news = TestData.testNews1;
      final newsJson = news.toJson();

      expect(news.toString() == News.fromJson(newsJson).toString(), true);
    });

    test('News fromJson compared to other News', () {
      final news = TestData.testNews1;
      final news2 = TestData.testNews2;
      final newsJson = news2.toJson();

      expect(news == News.fromJson(newsJson), false);
    });
  });

  group('News equals tests', (){
    test('News equals compared to self', () {
      final news = TestData.testNews1;

      expect(news == news, true);
    });

    test('News equals compared to self 2', () {
      final News news = TestData.testNews1;
      final news2 = News('A', 1, [TestData.testArticle1]);

      expect(news == news2, true);
    });

    test('News equals compared to other News', () {
      final news = TestData.testNews1;
      final news2 = TestData.testNews2;

      expect(news == news2, false);
    });
  });

  group('News hashCode tests', (){
    test('News hashCode compared to self', () {
      final news = TestData.testNews1;

      expect(news.hashCode == news.hashCode, true);
    });

    test('News hashCode compared to self 2', () {
      final news = TestData.testNews1;
      final news2 = News('A', 1, [TestData.testArticle1]);

      expect(news.hashCode == news2.hashCode, true);
    });

    test('News hashCode compared to other News', () {
      final news = TestData.testNews1;
      final news2 = TestData.testUser1;

      expect(news.hashCode == news2.hashCode, false);
    });
  });
}
