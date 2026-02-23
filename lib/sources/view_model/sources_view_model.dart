import 'package:flutter/material.dart';
import 'package:news_app/sources/data/models/source.dart';
import 'package:news_app/sources/data/data_sources/sources_data_source.dart';
import 'package:news_app/sources/data/models/sources_response.dart';

class SourcesViewModel with ChangeNotifier {
  List<Source> sources = [];
  SourcesDataSource dataSource =
      SourcesDataSource(); //object from SourcesDataSource()
  bool isLoading = false;
  String? errorMessage;
  Future<void> getSources(String categoryId) async {
    isLoading = true;
    try {
      SourcesResponse response = await dataSource.getSources(categoryId);
      if (response.status == 'ok' && response.sources != null) {
        sources = response.sources!;
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
