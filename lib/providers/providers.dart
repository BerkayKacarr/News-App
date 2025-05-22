import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/services/news_service.dart';

class NewsProvider with ChangeNotifier {
  List<Article> _articles = [];
  bool _isLoading = false;
  bool _hasError = false;

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchNews() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      _articles = await NewsService().fetchTopHeadlines();
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }
}
