import 'package:news_app/news/data/data_sources/news_api_data_source.dart';
import 'package:news_app/news/data/data_sources/news_data_source.dart';
import 'package:news_app/news/view_model/news_view_model.dart';
import 'package:news_app/sources/data/data_sources/sources_api_data_source.dart';
import 'package:news_app/sources/data/data_sources/sources_data_source.dart';
import 'package:news_app/sources/data/repository/news_repository.dart';
import 'package:news_app/sources/data/repository/sources_repository.dart';
import 'package:news_app/sources/view_model/sources_view_model.dart';

class ServiceLocaror {
  //sources
  static SourcesDataSource sourcesDataSource = SourcesAPIDataSource();
  static SourcesRepository sourcesRepository = SourcesRepository(
    sourcesDataSource,
  );
  static SourcesViewModel get sourcesViewModel =>
      SourcesViewModel(sourcesRepository);
  //news
  static NewsDataSource newsDataSource = NewsAPIDataSource();
  static NewsRepository newsRepository = NewsRepository(newsDataSource);
  static NewsViewModel get newsViewModel => NewsViewModel(newsRepository);
}
