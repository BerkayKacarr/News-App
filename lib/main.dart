import 'package:flutter/material.dart';
import 'package:news_app/providers/providers.dart';
import 'package:news_app/views/home_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NewsProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter News App',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(fontFamily: 'Roboto'),
          ),
        ),
        home: const HomeView(),
      ),
    );
  }
}
