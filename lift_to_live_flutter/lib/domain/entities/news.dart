import 'article.dart';

/// Entity class for holding details of a news fetch.
class News {
  String status; // status of the fetch
  int totalResults; // total number of fetch results
  List<Article> articles; // list of articles returned from the news fetch

  //Simple constructor for creating a news instance
  News(this.status, this.totalResults, this.articles);

  // Function used for transforming a JSON to an News object.
  News.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        totalResults = json['totalResults'],
        articles = List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x)));

  // Function used for transforming News object to JSON map.
  Map<String, dynamic> toJson() => {
        'status': status,
        'totalResults': totalResults,
        'articles': List<dynamic>.from(articles.map((x) => x.toJson())),
      };

  //Equals function
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is News &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          totalResults == other.totalResults;

  //Hashcode function
  @override
  int get hashCode => status.hashCode ^ totalResults.hashCode;
}
