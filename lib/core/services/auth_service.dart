
import 'dart:async';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class AuthService {
  final _storage = const FlutterSecureStorage();
  final _baseUrl = "https://cashlyservice.onrender.com";

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final String _serverClientId = '946215975972-pfrv4m5f1mms7s39chb9ldic6fg5buqv.apps.googleusercontent.com';

  GoogleSignInAccount? _currentUser;
  GoogleSignInAccount? get currentUser => _currentUser;
  StreamSubscription<GoogleSignInAuthenticationEvent>? _authSub;

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

  // Google SignIn
  Future<void> init() async {
    await _googleSignIn.initialize(
      serverClientId: _serverClientId,
    );

    _authSub = _googleSignIn.authenticationEvents.listen(_handleAuthEvent);
    _googleSignIn.attemptLightweightAuthentication();
  }

  void _handleAuthEvent(GoogleSignInAuthenticationEvent event) {
    switch (event) {
      case GoogleSignInAuthenticationEventSignIn():
        _currentUser = event.user;
        print('Usuario autenticado: ${_currentUser?.displayName}');
        break;
      case GoogleSignInAuthenticationEventSignOut():
        _currentUser = null;
        print('Sesión cerrada');
        break;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await _googleSignIn.authenticate();
    } catch (e) {
      print('Error al iniciar sesión: $e');
    }
  }

}

