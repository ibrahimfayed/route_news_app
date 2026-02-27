import 'package:flutter/material.dart';
import 'package:news_app/news/data/models/news.dart';
import 'package:news_app/sources/data/repository/news_repository.dart';

class NewsViewModel with ChangeNotifier {
  NewsRepository repository;
  NewsViewModel(this.repository);
  List<News> newsList = [];
  bool isLoading = false;
  String? errorMessage;
  
  Future<void> getNews(String sourceId) async {
    isLoading = true;
    try {
      newsList = await repository.getNews(sourceId);
      
    } catch (error) {
      errorMessage = error.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
