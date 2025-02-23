import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/currency.dart';

class ApiService {
  static const String baseUrl = 'https://api.vatcomply.com';

  Future<Map<String, Currency>> getCurrencies() async {
    final response = await http.get(Uri.parse('$baseUrl/currencies'));
    final data = json.decode(response.body) as Map<String, dynamic>;
    
    return data.map((key, value) => MapEntry(
      key,
      Currency.fromJson(key, value as Map<String, dynamic>),
    ));
  }

  Future<Map<String, double>> getRates(String baseCode) async {
    final response = await http.get(Uri.parse('$baseUrl/rates?base=$baseCode'));
    final data = json.decode(response.body) as Map<String, dynamic>;
    
    return (data['rates'] as Map<String, dynamic>)
        .map((key, value) => MapEntry(key, value as double));
  }
}
