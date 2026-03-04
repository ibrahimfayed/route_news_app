import 'package:news_app/news/data/models/news.dart';

abstract class NewsState {}

class NewsInitial extends NewsState{}

class GetNewsLoading extends NewsState {}

class GetNewsSuccess extends NewsState {
  List<News> newsList;
  GetNewsSuccess(this.newsList);
}

class GetNewsError extends NewsState {
  String message;
  GetNewsError(this.message);
}
