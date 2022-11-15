// coverage:ignore-file

import 'package:http/http.dart' as http;

/// This is a datasource object, which handles the communication with the Backend REST API.
/// The communication is done via http requests, using the http.dart package.
class NewsAPI {
  static final NewsAPI _singleton = NewsAPI._internal();

  factory NewsAPI() {
    return _singleton;
  }

  NewsAPI._internal();

  /// This function is used to fetch news articles from the newsapi.org API.
  /// It takes a search term and a number of articles to fetch.
  Future<http.Response> fetchNews(String search, int pageSize) async {
    var res = await http.get(
      Uri.parse(
          'https://newsapi.org/v2/everything?q=$search&language=en&sortBy=publishedAt&pageSize=$pageSize&apiKey=21b8ce1c0a3c495bb2b09d76a16b8d61'),
    );
    return res;
  }
}
