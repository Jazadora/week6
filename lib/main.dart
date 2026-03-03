import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/article_viewmodel.dart';
import 'views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ArticleViewModel()..loadArticles(),
      child: MaterialApp(
        title: 'Week 6 API Consumer App',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        home: const HomePage(),
      ),
    );
  }
}
