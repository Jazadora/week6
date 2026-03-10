class Coin {
  final String id;
  final String symbol;
  final String name;
  final String? image;
  final double currentPrice;
  final double marketCap;
  final double priceChangePercentage24h;
  final double totalVolume;

  Coin({
    required this.id,
    required this.symbol,
    required this.name,
    this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.priceChangePercentage24h,
    required this.totalVolume,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      id: json['id'] ?? '',
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? 'Unknown',
      image: json['image'],
      currentPrice: (json['current_price'] ?? 0).toDouble(),
      marketCap: (json['market_cap'] ?? 0).toDouble(),
      priceChangePercentage24h: (json['price_change_percentage_24h'] ?? 0)
          .toDouble(),
      totalVolume: (json['total_volume'] ?? 0).toDouble(),
    );
  }
}
