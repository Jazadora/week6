import 'package:flutter/material.dart';
import '../models/coin.dart';
import '../services/coin_service.dart';

class CoinViewModel extends ChangeNotifier {
  final CoinService _coinService = CoinService();

  List<Coin> _coins = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Coin> get coins => _coins;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadCoins() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _coins = await _coinService.fetchCoins();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> refreshCoins() async {
    await loadCoins();
  }
}
