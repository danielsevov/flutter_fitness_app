import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/entities/article.dart';

import '../mock_data.dart';

void main() {
  test('Article constructor test', () {
    final article = MockData.testArticle1;
    
    expect(article.title, 'A');
    expect(article.author, 'A');
    expect(article.url, 'A');
    expect(article.urlToImage, 'A');
    expect(article.description, 'A');
    expect(article.content, 'A');
  });

  group('Article toJson tests', (){
    test('Article toJson compared to self', () {
      final article = MockData.testArticle1;

      expect(article.toJson().toString() == article.toJson().toString(), true);
    });

    test('Article toJson compared to self 2', () {
      final article = MockData.testArticle1;

      expect(article.toJson().toString(), '{author: A, title: A, description: A, url: A, urlToImage: A, content: A}');
    });

    test('Article toJson compared to other', () {
      final article = MockData.testArticle1;
      final article2 = MockData.testArticle2;

      expect(article.toJson().toString() == article2.toJson().toString(), false);
    });
  });

  group('Article fromJson tests', (){
    test('Article fromJson compared to self', () {
      final article = MockData.testArticle1;
      final articleJson = article.toJson();

      expect(article == Article.fromJson(articleJson), true);
    });

    test('Article fromJson compared to other Article', () {
      final article = MockData.testArticle1;
      final article2 = MockData.testArticle2;
      final articleJson = article2.toJson();

      expect(article == Article.fromJson(articleJson), false);
    });
  });

  group('Article equals tests', (){
    test('Article equals compared to self', () {
      final article = MockData.testArticle1;

      expect(article == article, true);
    });

    test('Article equals compared to self 2', () {
      final Article article = MockData.testArticle1;
      final article2 = Article('A', 'A', 'A', 'A', 'A', 'A');

      expect(article == article2, true);
    });

    test('Article equals compared to other Article', () {
      final article = MockData.testArticle1;
      final article2 = MockData.testArticle2;

      expect(article == article2, false);
    });
  });

  group('Article hashCode tests', (){
    test('Article hashCode compared to self', () {
      final article = MockData.testArticle1;

      expect(article.hashCode == article.hashCode, true);
    });

    test('Article hashCode compared to self 2', () {
      final article = MockData.testArticle1;
      final article2 = Article('A', 'A', 'A', 'A', 'A', 'A');

      expect(article.hashCode == article2.hashCode, true);
    });

    test('Article hashCode compared to other Article', () {
      final article = MockData.testArticle1;
      final article2 = MockData.testUser1;

      expect(article.hashCode == article2.hashCode, false);
    });
  });
}
