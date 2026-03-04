import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news/data/models/news.dart';
import 'package:news_app/news/view_model/news_states.dart';
import 'package:news_app/sources/data/repository/news_repository.dart';

class NewsViewModel extends Cubit<NewsState> {
  NewsRepository repository;
  NewsViewModel(this.repository):super(NewsInitial());
  
  
  Future<void> getNews(String sourceId) async {
    emit(GetNewsLoading());
    try {
    List<News>  newsList = await repository.getNews(sourceId);
    emit(GetNewsSuccess(newsList));
      
    } catch (error) {
      emit(GetNewsError(error.toString()));
    }
   
  }
}
