import 'dart:collection';

import 'article.dart';
import 'habit_task.dart';

class News {
  String status;
  int totalResults;
  List<Article> articles;

  News(this.status, this.totalResults, this.articles);

  News.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        totalResults = json['totalResults'],
        articles = List<Article>.from(
            json["articles"]
                .map((x) => Article.fromJson(x)));

  Map<String, dynamic> toJson() => {
    'status': status,
    'totalResults': totalResults,
    'articles': List<dynamic>.from(articles.map((x) => x.toJson())),
  };
}