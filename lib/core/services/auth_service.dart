import 'dart:convert';
import 'package:cashly/core/models/user_model.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:http/http.dart' as http;

Future<http.Response?> loginService(String email, String pass) async {
  // TODO: usar url correcta y mostrar mensaje adecuado
  try {
    final user = User(
      usuarioNombre: "",
      usuarioApellido: "",
      usuarioCorreo: email,
      usuarioPassword: pass,
      usuarioPais: "",
      usuarioFechaNacimiento: DateTime.now(),
    );

    var url = Uri.https('', '');
    var response = await http.post(
      url,
      body: user.toJson(),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return null;
  } catch (e) {
    if (kDebugMode) {
      print("error: $e");
    }
    return null;
  }
}

Future<http.Response?> registerService({
  required String usuarioNombre,
  required String usuarioApellido,
  required String usuarioCorreo,
  required String usuarioPassword,
  required String usuarioPais,
  String? usuarioMoneda,
  required DateTime usuarioFechaNacimiento,
}) async {
  // TODO: usar url correcta y mostrar mensaje adecuado
  try {
    final user = User(
      usuarioNombre: usuarioNombre,
      usuarioApellido: usuarioApellido,
      usuarioCorreo: usuarioCorreo,
      usuarioPassword: usuarioPassword,
      usuarioPais: usuarioPais,
      usuarioFechaNacimiento: usuarioFechaNacimiento,
    );

    var url = Uri.https('', '');
    var response = await http.post(
      url,
      body: user.toJson(),
      headers: {"Content-Type": "application/json"},
    );

    if (kDebugMode) print(jsonDecode(response.body));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return null;
  } catch (e) {
    if (kDebugMode) {
      print("error: $e");
    }
    return null;
  }
}
