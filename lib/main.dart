import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_app/providers/providers.dart';
import 'package:news_app/views/home_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => NewsProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter News App',
      home: HomeView(),
    );
  }
}
