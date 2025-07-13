import 'dart:convert';

import 'package:cashly/core/models/metas.dart';
import 'package:cashly/feautures/goals/data/models/goal.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../feautures/goals/data/models/goal_detail.dart';
import '../constants/url.dart';

class GoalService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<GoalDetailModel> fetchGoalDetail() async {
    final token = await _storage.read(key: 'jwt');

    final response = await http.get(
      Uri.parse('$baseUrl/metas/detail'),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return GoalDetailModel.fromJson(data);
    } else {
      throw Exception('Error al cargar datos del dashboard');
    }
  }

  static Future<List<GoalModel>> fetchGoals() async {
    final token = await _storage.read(key: 'jwt');

    final response = await http.get(
      Uri.parse('$baseUrl/metas'),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<GoalModel> dataList =
          data
              .map((e) => GoalModel.fromJson(e as Map<String, dynamic>))
              .toList();
      return dataList;
    } else {
      throw Exception('Error al cargar datos del dashboard');
    }
  }

  static Future<void> postGoal(GoalModel goal) async {
    final token = await _storage.read(key: "jwt");

    await http.post(
      Uri.parse('$baseUrl/metas'),
      headers: {
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(goal.toJson()),
    );
  }
}
