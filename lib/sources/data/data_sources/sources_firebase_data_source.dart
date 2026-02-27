import 'package:news_app/sources/data/data_sources/sources_data_source.dart';
import 'package:news_app/sources/data/models/source.dart';

class SourcesFirebaseDataSource implements SourcesDataSource{
  Future<List<Source>>getSources(String categoryId)async{
    //firebase logic
    return [];
  }
  
}