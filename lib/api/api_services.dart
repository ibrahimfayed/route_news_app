import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api/api_constants.dart';
import 'package:news_app/models/news_response/news_response.dart';
import 'package:news_app/models/sources_response/sources_response.dart';

class APIServices {
  static Future<SourcesResponse> getSources(String categoryId) async {
    Uri uri = Uri.https(APIConstants.baseUrl, APIConstants.sourcesEndpoint, {
      'apiKey': APIConstants.apiKey,
      'category': categoryId,
    });
    http.Response response = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    return SourcesResponse.fromJson(json);
  }

  static Future<NewsResponse> getNews(
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
    return NewsResponse.fromJson(json);
  }
}
