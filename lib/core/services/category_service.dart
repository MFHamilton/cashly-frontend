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
}
