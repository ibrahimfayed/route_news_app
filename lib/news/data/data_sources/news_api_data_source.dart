import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/news/data/data_sources/news_data_source.dart';
import 'package:news_app/news/data/models/news.dart';
import 'package:news_app/shared/api_constants.dart';
import 'package:news_app/news/data/models/news_response.dart';
import 'package:news_app/sources/data/models/sources_response.dart';

class NewsAPIDataSource implements NewsDataSource {
  @override
  Future<List<News>> getNews(
    String sourceId,
    //   {
    //   int page = 1,
    //   int pageSize = 10,
    // }
  ) async {
    Uri uri = Uri.https(APIConstants.baseUrl, APIConstants.newsEndpoint, {
      'apiKey': APIConstants.apiKey,
      'sources': sourceId,
      // 'page': page.toString(),
      // 'pageSize': pageSize.toString(),
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    NewsResponse newsResponse = NewsResponse.fromJson(json);
    if (newsResponse.status == 'ok' && newsResponse.newsList != null) {
      return newsResponse.newsList!;
    } else {
      throw Exception('Faild To Get Sources');
    }
  }
}
