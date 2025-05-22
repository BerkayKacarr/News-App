import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailView extends StatelessWidget {
  final Article article;

  const ArticleDetailView({super.key, required this.article});

  void _launchURL(BuildContext context) async {
    final url = Uri.parse(article.url ?? '');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Link açılamadı')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article.title ?? 'Detay')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null)
              Image.network(
                article.urlToImage!,
                height: 200,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),
            Text(
              article.title ?? '',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              article.publishedAt ?? '',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(article.description ?? '', style: TextStyle(fontSize: 16)),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => _launchURL(context),
              icon: const Icon(Icons.open_in_browser),
              label: const Text("Haberi Kaynağında Oku"),
            ),
          ],
        ),
      ),
    );
  }
}
