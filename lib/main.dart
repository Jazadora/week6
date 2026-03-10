import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/coin_viewmodel.dart';
import 'views/coin_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CoinViewModel()..loadCoins(),
      child: MaterialApp(
        title: 'Crypto Market App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const CoinListPage(),
      ),
    );
  }
}
