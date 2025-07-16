import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/url.dart';

class IngresoService {
  final String _endpoint = '$baseUrl/ingreso';
  final storage = FlutterSecureStorage();

  Future<String?> _getToken() async {
    return await storage.read(key: 'jwt');
  }

  Future<List<dynamic>> getIngresos({int? month, int? year}) async {
    final token = await _getToken();

    final query = <String, String>{};
    if (month != null) query['mes'] = month.toString();
    if (year != null) query['anio'] = year.toString();

    final uri = Uri.parse(_endpoint).replace(queryParameters: query);

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('GET $uri');
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los ingresos');
    }
  }

  Future<Map<String, dynamic>> createIngreso(Map<String, dynamic> data) async {
    final token = await _getToken();

    final response = await http.post(
      Uri.parse(_endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al crear el ingreso');
    }
  }

  Future<Map<String, dynamic>> updateIngreso(int id, Map<String, dynamic> data) async {
    final token = await _getToken();

    final response = await http.put(
      Uri.parse('$_endpoint/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al actualizar el ingreso');
    }
  }

  Future<void> deleteIngreso(int ingresoId) async {
    final token = await _getToken();

    final response = await http.delete(
      Uri.parse('$_endpoint/$ingresoId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el ingreso');
    }
  }
}
