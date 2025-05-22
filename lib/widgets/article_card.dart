import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:intl/intl.dart';
import 'package:news_app/views/detail_view.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

  String formatDate(String dateStr) {
    try {
      final dateTime = DateTime.parse(dateStr);
      final formatter = DateFormat.yMMMd('tr_TR');
      return formatter.format(dateTime);
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailView(article: article),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            article.urlToImage.isNotEmpty
                ? ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.network(
                    article.urlToImage,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => const SizedBox(
                          height: 200,
                          child: Center(child: Icon(Icons.broken_image)),
                        ),
                  ),
                )
                : Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Center(child: Icon(Icons.image_not_supported)),
                ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                article.title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                article.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                formatDate(article.publishedAt),
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
