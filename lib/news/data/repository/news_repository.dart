import 'package:news_app/news/data/data_sources/news_data_source.dart';
import 'package:news_app/news/data/models/news.dart';

class NewsRepository {
  NewsDataSource dataSource;
  NewsRepository(this.dataSource);
  Future<List<News>> getNews(String sourceId) async {
    return dataSource.getNews(sourceId);
  }
}
