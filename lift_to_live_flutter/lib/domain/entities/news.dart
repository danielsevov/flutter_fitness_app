import 'article.dart';

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is News &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          totalResults == other.totalResults;

  @override
  int get hashCode =>
      status.hashCode ^ totalResults.hashCode;
}