import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('http://localhost:3000/auth/login');
    final resp = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'usuario_correo': email, 'usuario_password': password}),
    );
    final data = jsonDecode(resp.body);
    return {
      'status': resp.statusCode,
      'body': data,
    };
  }
}
