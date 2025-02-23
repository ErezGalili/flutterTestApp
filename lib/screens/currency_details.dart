import 'package:flutter/material.dart';
import '../models/currency.dart';
import '../services/api_service.dart';

class CurrencyDetailsScreen extends StatefulWidget {
  final String currencyCode;
  final Currency currency;

  const CurrencyDetailsScreen({
    super.key,
    required this.currencyCode,
    required this.currency,
  });

  @override
  State<CurrencyDetailsScreen> createState() => _CurrencyDetailsScreenState();
}

class _CurrencyDetailsScreenState extends State<CurrencyDetailsScreen> {
  final _apiService = ApiService();
  Map<String, double>? _rates;
  Map<String, Currency>? _currencies;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final rates = await _apiService.getRates(widget.currencyCode);
    final currencies = await _apiService.getCurrencies();
    setState(() {
      _rates = rates;
      _currencies = currencies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.currency.name),
      ),
      body: _rates == null || _currencies == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _rates!.length,
              itemBuilder: (context, index) {
                final code = _rates!.keys.elementAt(index);
                final rate = _rates![code]!;
                final currency = _currencies![code]!;
                return ListTile(
                  title: Text(
                    '${currency.name}: $rate${currency.symbol}',
                  ),
                );
              },
            ),
    );
  }
}
