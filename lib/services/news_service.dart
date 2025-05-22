import 'dart:convert';
import 'package:news_app/models/article.dart';
import 'package:http/http.dart' as http;

class NewsService {
  static const String _apiKey = '096a6429bd894eefb0bba1fa081274c0';
  static const String _baseUrl = 'https://newsapi.org/v2/top-headlines';
  static const String _country = 'us'; // ABD haberleri

  Future<List<Article>> fetchTopHeadlines() async {
    final url = Uri.parse('$_baseUrl?country=$_country&apiKey=$_apiKey');

    final response = await http.get(url);

    // Debug için status code ve response body yazdır
    print('Status Code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> articlesJson = jsonData['articles'];

      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Haberler alınamadı: ${response.statusCode}');
    }
  }
}
