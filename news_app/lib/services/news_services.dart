import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/news_model.dart';

class NewsService {
  static const String apiKey = "0a7bdfe011a74df6b521cbddba406b33";
  static const String baseUrl =
      "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$apiKey";

  Future<List<News>> getNews() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<News> newsList = [];
      for (var article in jsonData['articles']) {
        newsList.add(News(
          title: article['title'] ?? '',
          description: article['description'] ?? '',
          imageUrl: article['urlToImage'] ?? '',
        ));
      }
      return newsList;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
