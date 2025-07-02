class Ingresos {
  final int ingresoId;
  final int usuarioId;
  final String ingresoNombre;
  final double ingresoMonto;
  final DateTime? ingresoFecha;
  final int? periodoId;
  final int? categoriaId;
  final bool? ingresoFrecuencia;
  final DateTime? inicioRecurrencia;
  final DateTime? finRecurrencia;

  Ingresos({
    required this.ingresoId,
    required this.usuarioId,
    required this.ingresoNombre,
    required this.ingresoMonto,
    this.ingresoFecha,
    this.periodoId,
    this.categoriaId,
    this.ingresoFrecuencia,
    this.inicioRecurrencia,
    this.finRecurrencia,
  });

  factory Ingresos.fromJson(Map<String, dynamic> json) => Ingresos(
    ingresoId: json['ingreso_id'],
    usuarioId: json['usuario_id'],
    ingresoNombre: json['ingreso_nombre'],
    ingresoMonto: (json['ingreso_monto'] as num).toDouble(),
    ingresoFecha: json['ingreso_fecha'] == null
        ? null
        : DateTime.parse(json['ingreso_fecha']),
    periodoId: json['periodo_id'],
    categoriaId: json['categoria_id'],
    ingresoFrecuencia: json['ingreso_frecuencia'],
    inicioRecurrencia: json['inicio_recurrencia'] == null
        ? null
        : DateTime.parse(json['inicio_recurrencia']),
    finRecurrencia: json['fin_recurrencia'] == null
        ? null
        : DateTime.parse(json['fin_recurrencia']),
  );

  Map<String, dynamic> toJson() => {
    'ingreso_id': ingresoId,
    'usuario_id': usuarioId,
    'ingreso_nombre': ingresoNombre,
    'ingreso_monto': ingresoMonto,
    'ingreso_fecha': ingresoFecha?.toIso8601String(),
    'periodo_id': periodoId,
    'categoria_id': categoriaId,
    'ingreso_frecuencia': ingresoFrecuencia,
    'inicio_recurrencia': inicioRecurrencia?.toIso8601String(),
    'fin_recurrencia': finRecurrencia?.toIso8601String(),
  };
}