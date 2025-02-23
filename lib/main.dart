import 'package:flutter/material.dart';
import 'models/currency.dart';
import 'services/api_service.dart';
import 'screens/currency_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Exchange Rates',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _apiService = ApiService();
  Map<String, Currency>? _currencies;

  @override
  void initState() {
    super.initState();
    _loadCurrencies();
  }

  Future<void> _loadCurrencies() async {
    final currencies = await _apiService.getCurrencies();
    setState(() {
      _currencies = currencies;
    });
  }

  Widget _buildDrawer() {
    if (_currencies == null) {
      return Drawer(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Select Currency'),
          ),
          ..._currencies!.entries.map(
            (entry) => ListTile(
              title: Text(entry.value.name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CurrencyDetailsScreen(
                      currencyCode: entry.key,
                      currency: entry.value,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Exchange Rates'),
      ),
      drawer: _buildDrawer(),
      body: const Center(
        child: Text('Please Choose a Base'),
      ),
    );
  }
}
