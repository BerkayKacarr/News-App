class Article {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
  });

  // JSON'dan veri çekmek için factory constructor
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No title available',
      description: json['description'] ?? 'No description available',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
    );
  }
}
