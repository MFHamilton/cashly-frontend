import 'dart:convert';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:http/http.dart' as http;

Future<http.Response?> loginService(String email, String pass) async {
  // TODO: usar url correcta y mostrar mensaje adecuado
  try {
    var url = Uri.https('', '');
    var response = await http.post(
      url,
      body: {'usuario_correo': email, 'usuario_password': pass},
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
  required String usuario_nombre,
  required String usuario_apellido,
  required String usuario_correo,
  required String usuario_password,
  required String usuario_pais,
  String? usuario_moneda,
  required DateTime usuario_fecha_nacimiento,
}) async {
  // TODO: usar url correcta y mostrar mensaje adecuado
  try {
    var url = Uri.https('', '');
    var response = await http.post(
      url,
      body: {
        "usuario_nombre": usuario_nombre,
        "usuario_apellido": usuario_apellido,
        "usuario_correo": usuario_correo,
        "usuario_password": usuario_password,
        "usuario_pais": usuario_pais,
        "usuario_moneda": usuario_moneda,
        "usuario_fecha_nacimiento": usuario_fecha_nacimiento,
      },
    );

    if (kDebugMode) print(jsonDecode(response.body));

    return jsonDecode(response.body);
  } catch (e) {
    if (kDebugMode) {
      print("error: $e");
    }
    return null;
  }
}
