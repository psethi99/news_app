import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodel/news_viewmodel.dart';
import '../model/news_model.dart';
part '../bloc/news_state.dart';
part '../bloc/news_event.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsViewModel _viewModel = NewsViewModel();

  NewsBloc() : super(NewsInitial());

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is FetchNews) {
      yield NewsLoading();
      try {
        final List<News> newsList = await _viewModel.getNews();
        yield NewsLoaded(newsList: newsList);
      } catch (e) {
        yield NewsError(message: e.toString());
      }
    }
  }
}
