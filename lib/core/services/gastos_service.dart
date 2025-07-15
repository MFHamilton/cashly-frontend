import 'dart:convert';

import 'package:cashly/core/models/gastos.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constants/url.dart';

class GastosService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<List<double>> fetchGastosMontoMensual(int month, int year) async {
    final token = await _storage.read(key: "jwt");

    final response = await http.get(
      Uri.parse('$baseUrl/presupuesto?month=$month&year=$year'),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<double> dataList =
          data.map((e) => Gastos.fromJson(e).gastoMonto).toList();
      return dataList;
    } else {
      throw Exception('Error al cargar datos de presupuestos');
    }
  }
}
