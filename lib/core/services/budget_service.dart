import 'dart:convert';

import 'package:cashly/core/models/presupuestos.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constants/url.dart';

class BudgetService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<List<Presupuestos>> fetchBudget() async {
    final token = await _storage.read(key: "jwt");

    final response = await http.get(
      Uri.parse('$baseUrl/presupuesto'),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Presupuestos> dataList =
          data
              .map((e) => Presupuestos.fromJson(e as Map<String, dynamic>))
              .toList();
      return dataList;
    } else {
      throw Exception('Error al cargar datos de presupuestos');
    }
  }

  static Future<double> fetchBudgetAmount() async {
    final token = await _storage.read(key: "jwt");

    final response = await http.get(
      Uri.parse('$baseUrl/presupuesto'),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return double.parse(data["amount"]);
    } else {
      throw Exception('Error al cargar datos de presupuestos');
    }
  }

  static Future<void> postBudget(Presupuestos budget) async {
    final token = await _storage.read(key: "jwt");

    print("body del request: ${jsonEncode(budget.toJson())}");
    final response = await http.post(
      Uri.parse('$baseUrl/presupuesto'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(budget.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception(
        "No se creo el presupuesto correctamente, Error: ${response.body}",
      );
    }
    print(response.statusCode);
  }
}
