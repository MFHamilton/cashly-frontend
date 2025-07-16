import 'dart:convert';

import 'package:cashly/core/models/categoria.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constants/url.dart' show baseUrl;

class CategoryService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<List<Categoria>> fetchCategories() async {
    final token = await _storage.read(key: 'jwt');

    final response = await http.get(
      Uri.parse('$baseUrl/categoria'),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Categoria> listData =
          data
              .map((c) => Categoria.fromJson(c))
              .toList();
      return listData;
    } else {
      throw Exception('Error al cargar categorias');
    }
  }

  static Future<Categoria> createCategory({
    required String nombre,
    String? descripcion,
    required String iconRef,
  }) async {
    final token = await _storage.read(key: 'jwt');
    final uri = Uri.parse('$baseUrl/categoria');
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'nombre': nombre,
        'descripcion': descripcion,
        'iconRef': iconRef,
      }),
    );
    if (response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Categoria.fromJson(data);
    } else {
      throw Exception('Error creando categoría: ${response.statusCode}');
    }
  }
}
