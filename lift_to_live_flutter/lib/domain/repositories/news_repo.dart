import '../entities/news.dart';

/// API to the News repository object.
/// Defines method to be implemented.
abstract class NewsRepository {

  /// This function is used for fetching a News object, containing Articles.
  Future<News> getNews(String search, int count);
}