class Usuarios {
  final int usuarioId;
  final String usuarioNombre;
  final String usuarioApellido;
  final DateTime usuarioFechaNacimiento;
  final String usuarioCorreo;
  final String usuarioPassword;
  final String usuarioPais;
  final String? moneda;

  Usuarios({
    required this.usuarioId,
    required this.usuarioNombre,
    required this.usuarioApellido,
    required this.usuarioFechaNacimiento,
    required this.usuarioCorreo,
    required this.usuarioPassword,
    required this.usuarioPais,
    this.moneda,
  });

  factory Usuarios.fromJson(Map<String, dynamic> json) => Usuarios(
    usuarioId: json['usuario_id'],
    usuarioNombre: json['usuario_nombre'],
    usuarioApellido: json['usuario_apellido'],
    usuarioFechaNacimiento: DateTime.parse(json['usuario_fecha_nacimiento']),
    usuarioCorreo: json['usuario_correo'],
    usuarioPassword: json['usuario_password'],
    usuarioPais: json['usuario_pais'],
    moneda: json['moneda'],
  );

  Map<String, dynamic> toJson() => {
    'usuario_id': usuarioId,
    'usuario_nombre': usuarioNombre,
    'usuario_apellido': usuarioApellido,
    'usuario_fecha_nacimiento': usuarioFechaNacimiento.toIso8601String(),
    'usuario_correo': usuarioCorreo,
    'usuario_password': usuarioPassword,
    'usuario_pais': usuarioPais,
    'moneda': moneda,
  };
}
