class Presupuestos {
  final int presId;
  final int usuarioId;
  final String presNombre;
  final double presMontoInicial;
  final double presMontoUlt;
  final int? categoriaId;
  final int? periodoId;
  final bool esActivo;
  final DateTime fechaCreacion;
  final DateTime fechaUltAct;
  final DateTime? inicioRecurrencia;
  final DateTime? finRecurrencia;

  Presupuestos({
    required this.presId,
    required this.usuarioId,
    required this.presNombre,
    required this.presMontoInicial,
    required this.presMontoUlt,
    this.categoriaId,
    this.periodoId,
    required this.esActivo,
    required this.fechaCreacion,
    required this.fechaUltAct,
    this.inicioRecurrencia,
    this.finRecurrencia,
  });

  factory Presupuestos.fromJson(Map<String, dynamic> json) => Presupuestos(
    presId: json['pres_id'],
    usuarioId: json['usuario_id'],
    presNombre: json['pres_nombre'],
    presMontoInicial: (json['pres_monto_inicial'] as num).toDouble(),
    presMontoUlt: (json['pres_monto_ult'] as num).toDouble(),
    categoriaId: json['categoria_id'],
    periodoId: json['periodo_id'],
    esActivo: json['es_activo'],
    fechaCreacion: DateTime.parse(json['fecha_creacion']),
    fechaUltAct: DateTime.parse(json['fecha_ult_act']),
    inicioRecurrencia: json['inicio_recurrencia'] == null
        ? null
        : DateTime.parse(json['inicio_recurrencia']),
    finRecurrencia: json['fin_recurrencia'] == null
        ? null
        : DateTime.parse(json['fin_recurrencia']),
  );

  Map<String, dynamic> toJson() => {
    'pres_id': presId,
    'usuario_id': usuarioId,
    'pres_nombre': presNombre,
    'pres_monto_inicial': presMontoInicial,
    'pres_monto_ult': presMontoUlt,
    'categoria_id': categoriaId,
    'periodo_id': periodoId,
    'es_activo': esActivo,
    'fecha_creacion': fechaCreacion.toIso8601String(),
    'fecha_ult_act': fechaUltAct.toIso8601String(),
    'inicio_recurrencia': inicioRecurrencia?.toIso8601String(),
    'fin_recurrencia': finRecurrencia?.toIso8601String(),
  };
}
