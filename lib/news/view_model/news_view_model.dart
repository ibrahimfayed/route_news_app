import 'package:flutter/material.dart';
import 'package:news_app/news/data/data_sources/news_data_source.dart';
import 'package:news_app/news/data/models/news.dart';
import 'package:news_app/news/data/models/news_response.dart';

class NewsViewModel with ChangeNotifier {
  List<News> newsList = [];
  bool isLoading = false;
  String? errorMessage;
  NewsDataSource dataSource = NewsDataSource();
  Future<void> getNews(String sourceId) async {
    isLoading = true;
    try {
      NewsResponse response = await dataSource.getNews(sourceId);
      if (response.status == 'ok' && response.newsList != null) {
        newsList = response.newsList!;
      } else {
        errorMessage = 'Faild To Get Sources';
      }
    } catch (error) {
      errorMessage = error.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
