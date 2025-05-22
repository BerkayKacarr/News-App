import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailView extends StatelessWidget {
  final Article article;

  const DetailView({super.key, required this.article});

  String formatDate(String dateStr) {
    try {
      final dateTime = DateTime.parse(dateStr);
      final formatter = DateFormat.yMMMMd('tr_TR').add_Hm();
      return formatter.format(dateTime);
    } catch (e) {
      return dateStr;
    }
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Haber Detayı')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            article.urlToImage.isNotEmpty
                ? Image.network(
                  article.urlToImage,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => const SizedBox(
                        height: 250,
                        child: Center(child: Icon(Icons.broken_image)),
                      ),
                )
                : Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: const Center(child: Icon(Icons.image_not_supported)),
                ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                article.title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                formatDate(article.publishedAt),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                article.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () => _launchURL(article.url),
                child: const Text('Haberi Web Sitesinde Oku'),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
