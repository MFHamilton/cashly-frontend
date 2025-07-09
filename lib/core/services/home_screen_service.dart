import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/dashboard.dart' show HomeScreenDashboardModel;
import '../models/home_screen_chart.dart' show HomeScreenChartModel;
import '../models/home_screen_income.dart' show HomeScreenIncomeModel;

class HomeScreenService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const String baseUrl = 'https://cashlyservice.onrender.com';

  static Future<HomeScreenDashboardModel> fetchDashboardData() async {
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
      return HomeScreenDashboardModel.fromJson(data);
    } else {
      throw Exception('Error al cargar datos del dashboard');
    }
  }

  static Future<List<HomeScreenChartModel>> fetchChartData() async {
    final token = await _storage.read(key: "jwt");
    final response = await http.get(
      Uri.parse("$baseUrl/dashboard/chart"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final dataList =
          data.map((e) => HomeScreenChartModel.fromJson(e)).toList();
      return dataList;
    } else {
      throw Exception("Error al cargar datos de la gráfica");
    }
  }

  static Future<List<HomeScreenIncomeModel>> fetchIncomeList() async {
    final token = await _storage.read(key: "token");
    final response = await http.get(
      Uri.parse("$baseUrl/dashboard/income"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final dataList =
          data.map((e) => HomeScreenIncomeModel.fromJson(e)).toList();
      return dataList;
    } else {
      throw Exception("Error al cargar datos de ingresos");
    }
  }
}
