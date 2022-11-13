import '../entities/news.dart';

abstract class NewsRepository {
  Future<News> getNews(String search, int count);
}