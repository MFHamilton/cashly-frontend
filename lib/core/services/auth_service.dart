
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';





class AuthService {
  final _storage = const FlutterSecureStorage();
  final _baseUrl = "https://cashlyservice.onrender.com";

  Future<String> register({
    required String nombre,
    required String apellido,
    required String correo,
    required String password,
    required String pais,
    String? moneda,
    required DateTime fechaNacimiento,
  }) async {
    final uri = Uri.parse('$_baseUrl/auth/register');
    final resp = await http.post(uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'usuario_nombre': nombre,
        'usuario_apellido': apellido,
        'usuario_correo': correo,
        'usuario_password': password,
        'usuario_pais': pais,
        'usuario_moneda': moneda,
        'usuario_fecha_nacimiento': fechaNacimiento.toIso8601String(),
      }),
    );
    if (resp.statusCode == 201) {
      final token = json.decode(resp.body)['token'] as String;
      await _storage.write(key: 'jwt', value: token);
      return token;
    } else {
      throw Exception('Register failed: ${resp.body}');
    }
  }

  Future<String> login({
    required String correo,
    required String password,
  }) async {
    final uri = Uri.parse('$_baseUrl/auth/login');
    final resp = await http.post(uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'usuario_correo': correo,
        'usuario_password': password,
      }),
    );
    if (resp.statusCode == 200) {
      final token = json.decode(resp.body)['token'] as String;
      await _storage.write(key: 'jwt', value: token);
      return token;
    } else {
      throw Exception('Login failed: ${resp.body}');
    }
  }

  Future<Map<String, dynamic>> fetchProfile(int id) async {
    final token = await _storage.read(key: 'jwt');
    if (token == null) throw Exception('No JWT found');
    final uri = Uri.parse('$_baseUrl/profile/$id');
    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (resp.statusCode == 200) {
      return json.decode(resp.body) as Map<String, dynamic>;
    } else {
      throw Exception('Profile fetch failed: ${resp.body}');
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'jwt');
  }
}

