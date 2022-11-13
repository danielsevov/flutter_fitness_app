import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/entities/news.dart';

import '../test_data.dart';

void main() {
  test('News constructor test', () {
    final news = TestData.test_news_1;

    expect(news.articles, [TestData.test_article_1]);
    expect(news.status, 'A');
    expect(news.totalResults, 1);
  });

  group('News toJson tests', (){
    test('News toJson compared to self', () {
      final news = TestData.test_news_1;

      expect(news.toJson().toString() == news.toJson().toString(), true);
    });

    test('News toJson compared to self 2', () {
      final news = TestData.test_news_1;

      expect(news.toJson().toString(), '{status: A, totalResults: 1, articles: [{author: A, title: A, description: A, url: A, urlToImage: A, content: A}]}');
    });

    test('News toJson compared to other', () {
      final news = TestData.test_news_1;
      final news2 = TestData.test_news_2;

      expect(news.toJson().toString() == news2.toJson().toString(), false);
    });
  });

  group('News fromJson tests', (){
    test('News fromJson compared to self', () {
      final news = TestData.test_news_1;
      final newsJson = news.toJson();

      expect(news.toString() == News.fromJson(newsJson).toString(), true);
    });

    test('News fromJson compared to other News', () {
      final news = TestData.test_news_1;
      final news2 = TestData.test_news_2;
      final newsJson = news2.toJson();

      expect(news == News.fromJson(newsJson), false);
    });
  });

  group('News equals tests', (){
    test('News equals compared to self', () {
      final news = TestData.test_news_1;

      expect(news == news, true);
    });

    test('News equals compared to self 2', () {
      final News news = TestData.test_news_1;
      final news2 = News('A', 1, [TestData.test_article_1]);

      expect(news == news2, true);
    });

    test('News equals compared to other News', () {
      final news = TestData.test_news_1;
      final news2 = TestData.test_news_2;

      expect(news == news2, false);
    });
  });

  group('News hashCode tests', (){
    test('News hashCode compared to self', () {
      final news = TestData.test_news_1;

      expect(news.hashCode == news.hashCode, true);
    });

    test('News hashCode compared to self 2', () {
      final news = TestData.test_news_1;
      final news2 = News('A', 1, [TestData.test_article_1]);

      expect(news.hashCode == news2.hashCode, true);
    });

    test('News hashCode compared to other News', () {
      final news = TestData.test_news_1;
      final news2 = TestData.test_user_1;

      expect(news.hashCode == news2.hashCode, false);
    });
  });
}
