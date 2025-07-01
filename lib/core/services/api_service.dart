import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class ApiService {
  final _baseUrl = "https://cashlyservice.onrender.com";
  final _storage = const FlutterSecureStorage();
  final http.Client _client;

  ApiService([http.Client? client]) : _client = client ?? http.Client();

  Future<Map<String,String>> _authHeaders() async {
    final token = await _storage.read(key: 'jwt');
    if (token == null) throw Exception('Usuario no autenticado');
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }


}

