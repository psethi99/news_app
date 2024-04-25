import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'event.dart';
import 'state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataInitial());

  bool _isDarkMode = false;

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is FetchData) {
      try {
        final List<String> images = await _fetchDataFromApi();
        yield DataLoaded(images);
      } catch (_) {
        // Handle error
      }
    } else if (event is ToggleDarkMode) {
      _isDarkMode = !_isDarkMode;
      yield DarkModeChanged(_isDarkMode);
    }
  }

  Future<List<String>> _fetchDataFromApi() async {
    final apiKey = "0a7bdfe011a74df6b521cbddba406b33";
    final Uri apiUrl = Uri.parse(
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$apiKey");
    final response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> articles = jsonData['articles'];
      final List<String> images = (jsonData['articles'] as List<dynamic>)
          .map((article) => article['urlToImage'] as String)
          .toList();

      return images;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
