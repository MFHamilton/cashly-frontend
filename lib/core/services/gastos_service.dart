import 'dart:convert';
import 'package:cashly/core/models/gastos.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/url.dart'; // Aquí está tu baseUrl

class GastosService {
  final String _endpoint = '$baseUrl/gastos';
  final storage = FlutterSecureStorage();

  Future<String?> _getToken() async {
    return await storage.read(key: 'jwt',);
  }

  Future<List<dynamic>> getGastos({int? month, int? year, int? presId}) async {
    final token = await _getToken();

    final query = <String, String>{};
    if (month  != null) query['month']  = month.toString();
    if (year   != null) query['year']   = year.toString();
    if (presId != null) query['pres_id']= presId.toString();


    final uri = Uri.parse(_endpoint).replace(queryParameters: query);

    final resp = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (resp.statusCode == 200) {
      return json.decode(resp.body);
    } else {
      throw Exception('Error al cargar los gastos: ${resp.statusCode}');
    }
  }

  Future<Map<String, dynamic>> createGasto(Map<String, dynamic> data) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse(_endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );

    print("Status: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al crear el gasto');
    }
  }

  Future<Map<String, dynamic>> updateGasto(Map<String, dynamic> data) async {
    final token = await _getToken();
    final response = await http.put(
      Uri.parse(_endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al actualizar el gasto');
    }
  }

  Future<void> deleteGasto(int gastoId) async {
    final token = await _getToken();
    final response = await http.delete(
      Uri.parse(_endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'gasto_id': gastoId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el gasto');
    }
  }

  Future<List<double>> fetchGastosMontoMensual(int month, int year, int presId) async {
    final token = await _getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/presupuesto?month=$month&year=$year&pres_id=$presId'),
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
