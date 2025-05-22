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
  @override
  void initState() {
    super.initState();

    // Build tamamlandıktan sonra fetchNews çağrısı
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsProvider>(context, listen: false).fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    if (newsProvider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (newsProvider.hasError) {
      return const Scaffold(
        body: Center(child: Text('Haberler yüklenirken hata oluştu.')),
      );
    }

    if (newsProvider.articles.isEmpty) {
      return const Scaffold(body: Center(child: Text('Henüz haber yok.')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Gündem Haberleri')),
      body: ListView.builder(
        itemCount: newsProvider.articles.length,
        itemBuilder: (context, index) {
          return ArticleCard(article: newsProvider.articles[index]);
        },
      ),
    );
  }
}
