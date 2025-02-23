class Currency {
  final String code;
  final String name;
  final String symbol;

  Currency({
    required this.code,
    required this.name,
    required this.symbol,
  });

  factory Currency.fromJson(String code, Map<String, dynamic> json) {
    return Currency(
      code: code,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
    );
  }
}
