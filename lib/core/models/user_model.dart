import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String usuarioNombre;
  String usuarioApellido;
  String usuarioCorreo;
  String usuarioPassword;
  String usuarioPais;
  String? usuarioMoneda;
  DateTime usuarioFechaNacimiento;

  User({
    required this.usuarioNombre,
    required this.usuarioApellido,
    required this.usuarioCorreo,
    required this.usuarioPassword,
    required this.usuarioPais,
    this.usuarioMoneda,
    required this.usuarioFechaNacimiento,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    usuarioNombre: json["usuario_nombre"],
    usuarioApellido: json["usuario_apellido"],
    usuarioCorreo: json["usuario_correo"],
    usuarioPassword: json["usuario_password"],
    usuarioPais: json["usuario_pais"],
    usuarioMoneda: json["usuario_moneda"],
    usuarioFechaNacimiento: DateTime.parse(json["usuario_fecha_nacimiento"]),
  );

  Map<String, dynamic> toJson() => {
    "usuario_nombre": usuarioNombre,
    "usuario_apellido": usuarioApellido,
    "usuario_correo": usuarioCorreo,
    "usuario_password": usuarioPassword,
    "usuario_pais": usuarioPais,
    "usuario_moneda": usuarioMoneda,
    "usuario_fecha_nacimiento":
        "${usuarioFechaNacimiento.year.toString().padLeft(4, '0')}-${usuarioFechaNacimiento.month.toString().padLeft(2, '0')}-${usuarioFechaNacimiento.day.toString().padLeft(2, '0')}",
  };
}
