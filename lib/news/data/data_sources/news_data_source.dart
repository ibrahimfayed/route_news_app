import 'package:news_app/news/data/models/news.dart';
//interface
abstract class NewsDataSource {
  Future<List<News>> getNews(String sourceId);
}
