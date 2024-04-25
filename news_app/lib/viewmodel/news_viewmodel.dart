import '../model/news_model.dart';
import '../services/news_services.dart';

class NewsViewModel {
  final NewsService _newsService = NewsService();

  Future<List<News>> getNews() async {
    return await _newsService.getNews();
  }
}
