import '../entities/news.dart';

abstract class NewsRepository {
  Future<News> getNews();
}