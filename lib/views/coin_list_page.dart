import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/coin_viewmodel.dart';
import '../models/coin.dart';

class CoinListPage extends StatelessWidget {
  const CoinListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CoinViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Market'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => viewModel.refreshCoins(),
          ),
        ],
      ),
      body: _buildBody(context, viewModel),
    );
  }

  Widget _buildBody(BuildContext context, CoinViewModel viewModel) {
    if (viewModel.isLoading && viewModel.coins.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error loading data',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(viewModel.errorMessage!, textAlign: TextAlign.center),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => viewModel.loadCoins(),
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (viewModel.coins.isEmpty) {
      return const Center(child: Text('No coins available'));
    }

    return RefreshIndicator(
      onRefresh: () => viewModel.refreshCoins(),
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: viewModel.coins.length,
        itemBuilder: (context, index) {
          final coin = viewModel.coins[index];
          return _buildCoinCard(coin, index);
        },
      ),
    );
  }

  Widget _buildCoinCard(Coin coin, int index) {
    final isPositive = coin.priceChangePercentage24h >= 0;
    final changeColor = isPositive ? Colors.green : Colors.red;
    final changeIcon = isPositive ? Icons.arrow_upward : Icons.arrow_downward;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 28,
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 8),
            coin.image != null
                ? Image.network(
                    coin.image!,
                    width: 40,
                    height: 40,
                    errorBuilder: (_, __, ___) => const CircleAvatar(
                      radius: 20,
                      child: Icon(Icons.currency_bitcoin),
                    ),
                  )
                : const CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.currency_bitcoin),
                  ),
          ],
        ),
        title: Text(
          coin.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          coin.symbol.toUpperCase(),
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${_formatPrice(coin.currentPrice)}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(changeIcon, size: 14, color: changeColor),
                Text(
                  '${coin.priceChangePercentage24h.toStringAsFixed(2)}%',
                  style: TextStyle(color: changeColor, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    if (price >= 1000) {
      return price
          .toStringAsFixed(2)
          .replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (m) => '${m[1]},',
          );
    } else if (price >= 1) {
      return price.toStringAsFixed(2);
    } else {
      return price.toStringAsFixed(6);
    }
  }
}
