import 'package:news_app/sources/data/models/source.dart';
//interface
abstract class SourcesDataSource {
  Future<List<Source>>getSources(String categoryId);
  
}