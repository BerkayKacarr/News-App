import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/services/news_service.dart';

class NewsProvider with ChangeNotifier {
  List<Article> _articles = [];
  bool _isLoading = false;
  bool _hasError = false;
  String _selectedCategory = 'general'; // Varsayılan kategori

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get selectedCategory => _selectedCategory;

  Future<void> fetchNews() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      _articles = await NewsService().fetchTopHeadlines(
        category: _selectedCategory,
      );
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    fetchNews();
    notifyListeners(); // Kategori değiştiğinde UI'ı güncelle
  }
}
