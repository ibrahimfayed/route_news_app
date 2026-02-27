import 'package:flutter/material.dart';
import 'package:news_app/sources/data/data_sources/sources_api_data_source.dart';
import 'package:news_app/sources/data/models/source.dart';
import 'package:news_app/sources/data/repository/sources_repository.dart';

class SourcesViewModel with ChangeNotifier {
  SourcesRepository repository;
  SourcesViewModel(this.repository);
  List<Source> sources = [];
  bool isLoading = false;
  String? errorMessage;
  Future<void> getSources(String categoryId) async {
    isLoading = true;
    try {
      sources = await repository.getSources(categoryId);
    } catch (error) {
      errorMessage = error.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
