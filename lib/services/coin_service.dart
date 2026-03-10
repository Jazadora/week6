import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/coin.dart';

class CoinService {
  final String baseUrl = 'api.coingecko.com';

  Future<List<Coin>> fetchCoins() async {
    final uri = Uri.https(baseUrl, '/api/v3/coins/markets', {
      'vs_currency': 'usd',
      'order': 'market_cap_desc',
      'per_page': '50',
      'page': '1',
      'sparkline': 'false',
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Coin.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load coins: ${response.statusCode}');
    }
  }
}
