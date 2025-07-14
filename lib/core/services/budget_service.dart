import 'dart:convert';

import 'package:cashly/core/models/presupuestos.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constants/url.dart';

class BudgetService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> postBudget(Presupuestos budget) async {
    final token = await _storage.read(key: "jwt");

    print("body del request: ${jsonEncode(budget.toJson())}");
    final response = await http.post(
      Uri.parse('$baseUrl/metas'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(budget.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception("No se creo el presupuesto correctamente, Error: ${response.body}");
    }
    print(response.statusCode);
  }
}