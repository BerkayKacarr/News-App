import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_app/providers/providers.dart';
import 'package:news_app/widgets/article_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<String> categories = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology',
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<NewsProvider>(context, listen: false).fetchNews(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Gündem Haberleri'), centerTitle: true),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = newsProvider.selectedCategory == category;

                return GestureDetector(
                  onTap: () {
                    newsProvider.setCategory(category);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      category[0].toUpperCase() + category.substring(1),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: Builder(
              builder: (_) {
                if (newsProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (newsProvider.hasError) {
                  return const Center(
                    child: Text('Haberler yüklenirken hata oluştu.'),
                  );
                }

                if (newsProvider.articles.isEmpty) {
                  return const Center(child: Text('Henüz haber yok.'));
                }

                return ListView.builder(
                  itemCount: newsProvider.articles.length,
                  itemBuilder: (context, index) {
                    return ArticleCard(article: newsProvider.articles[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
