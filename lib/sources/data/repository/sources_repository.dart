import 'package:news_app/sources/data/data_sources/sources_data_source.dart';
import 'package:news_app/sources/data/models/source.dart';

class SourcesRepository {
  SourcesDataSource dataSource;
  SourcesRepository(this.dataSource);

  Future<List<Source>> getSources(String categoryId) async {
    return dataSource.getSources(categoryId);
  }
}
