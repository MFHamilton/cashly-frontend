import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../models/dashboard_model.dart';

class DashboardService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const String baseUrl = 'https://cashlyservice.onrender.com';

  static Future<DashboardModel> fetchDashboardData() async {
    final token = await _storage.read(key: 'jwt');
    final response = await http.get(
      Uri.parse('$baseUrl/dashboard'),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return DashboardModel.fromJson(data);
    } else {
      throw Exception('Error al cargar datos del dashboard');
    }
  }
}
