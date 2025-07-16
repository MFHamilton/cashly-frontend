// lib/core/services/presupuesto_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/url.dart';

class PresupuestoService {
  final String _endpoint = '$baseUrl/presupuesto';
  final _storage = const FlutterSecureStorage();

  Future<String?> _getToken() async {
    return await _storage.read(key: 'jwt');
  }

  /// Obtiene la lista de presupuestos del usuario
  Future<List<dynamic>> getPresupuestos() async {
    final token = await _getToken();
    final uri = Uri.parse(_endpoint);

    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print('GET $uri → ${resp.statusCode}');
    print('Body: ${resp.body}');

    if (resp.statusCode == 201 || resp.statusCode == 200) {
      return json.decode(resp.body);
    } else {
      throw Exception('Error al cargar los presupuestos (${resp.statusCode})');
    }
  }

  /// Obtiene el detalle agregado (p.ej. total) de presupuestos
  Future<Map<String, dynamic>> getPresupuestosDetail() async {
    final token = await _getToken();
    final uri = Uri.parse('$_endpoint/detail');

    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print('GET $uri → ${resp.statusCode}');
    print('Body: ${resp.body}');

    if (resp.statusCode == 200) {
      return json.decode(resp.body);
    } else {
      throw Exception('Error al cargar detalle de presupuestos (${resp.statusCode})');
    }
  }

  /// Crea un nuevo presupuesto
  Future<Map<String, dynamic>> createPresupuesto(Map<String, dynamic> data) async {
    final token = await _getToken();
    final uri = Uri.parse(_endpoint);

    final resp = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );
    print('POST $uri');
    print('Body enviado: ${json.encode(data)}');
    print('→ ${resp.statusCode}: ${resp.body}');

    if (resp.statusCode == 201) {
      return json.decode(resp.body);
    } else {
      throw Exception('Error al crear presupuesto (${resp.statusCode})');
    }
  }

  /// Actualiza un presupuesto existente (envía pres_id en el body)
  Future<Map<String, dynamic>> updatePresupuesto(Map<String, dynamic> data) async {
    final token = await _getToken();
    final uri = Uri.parse(_endpoint);

    final resp = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );
    print('PUT $uri');
    print('Body enviado: ${json.encode(data)}');
    print('→ ${resp.statusCode}: ${resp.body}');

    if (resp.statusCode == 200) {
      return json.decode(resp.body);
    } else {
      throw Exception('Error al actualizar presupuesto (${resp.statusCode})');
    }
  }

  /// Elimina un presupuesto (envía pres_id en el body)
  Future<void> deletePresupuesto(int presId) async {
    final token = await _getToken();
    final uri = Uri.parse(_endpoint);

    final resp = await http.delete(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'pres_id': presId}),
    );
    print('DELETE $uri');
    print('Body enviado: ${json.encode({'pres_id': presId})}');
    print('→ ${resp.statusCode}: ${resp.body}');

    if (resp.statusCode != 200) {
      throw Exception('Error al eliminar presupuesto (${resp.statusCode})');
    }
  }
}

