import 'package:flutter/material.dart';
import 'package:news_app/providers/providers.dart';
import 'package:news_app/widgets/article_card.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    // Uygulama ilk açıldığında haberleri çek
    Provider.of<NewsProvider>(context, listen: false).fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Güncel Haberler"), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: () => newsProvider.fetchNews(),
        child: Builder(
          builder: (context) {
            if (newsProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (newsProvider.hasError) {
              return Center(
                child: Text(
                  'Bir hata oluştu. Lütfen tekrar deneyin.',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            } else {
              final articles = newsProvider.articles;

              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(12),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return ArticleCard(article: articles[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
