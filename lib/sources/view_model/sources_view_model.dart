import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/sources/data/models/source.dart';
import 'package:news_app/sources/data/repository/sources_repository.dart';
import 'package:news_app/sources/view_model/sources_state.dart';

class SourcesViewModel extends Cubit<SourcesState> {
  SourcesRepository repository;
  SourcesViewModel(this.repository) : super(SourcesInitial());
  Future<void> getSources(String categoryId) async {
    emit(GetSourcesLoading());
    try {
      List<Source> sources = await repository.getSources(categoryId);
      emit(GetSourcesSuccess(sources));
    } catch (error) {
      GetSourcesError(error.toString());
    }
  }
}
