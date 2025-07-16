class Gastos {
  final int gastoId;
  final int usuarioId;
  final int? presId;
  final int? categoriaId;
  final String? categoriaNom;
  final int? periodoId;
  final String gastoNombre;
  final double gastoMonto;
  final DateTime? gastoFecha;
  final bool? gastoFrecuencia;
  final DateTime? inicioRecurrencia;
  final DateTime? finRecurrencia;

  Gastos({
    required this.gastoId,
    required this.usuarioId,
    this.presId,
    this.categoriaId,
    this.categoriaNom,
    this.periodoId,
    required this.gastoNombre,
    required this.gastoMonto,
    this.gastoFecha,
    this.gastoFrecuencia,
    this.inicioRecurrencia,
    this.finRecurrencia,
  });

  factory Gastos.fromJson(Map<String, dynamic> json) => Gastos(
    gastoId: int.parse(json['gasto_id'].toString()),
    usuarioId: int.parse(json['usuario_id'].toString()),
    presId: int.tryParse(json['pres_id']?.toString() ?? ''),
    categoriaId: int.tryParse(json['categoria_id']?.toString() ?? ''),
    categoriaNom: json['categoria_nom'],
    periodoId: int.tryParse(json['periodo_id']?.toString() ?? ''),
    gastoNombre: json['gasto_nombre'],
    gastoMonto: double.tryParse(json['gasto_monto']?.toString() ?? '') ?? 0.0,
    gastoFecha:
        json['gasto_fecha'] == null
            ? null
            : DateTime.parse(json['gasto_fecha']),
    gastoFrecuencia: json['gasto_frecuencia'],
    inicioRecurrencia:
        json['inicio_recurrencia'] == null
            ? null
            : DateTime.parse(json['inicio_recurrencia']),
    finRecurrencia:
        json['fin_recurrencia'] == null
            ? null
            : DateTime.parse(json['fin_recurrencia']),
  );

  Map<String, dynamic> toJson() => {
    'gasto_id': gastoId,
    'usuario_id': usuarioId,
    'pres_id': presId,
    'categoria_id': categoriaId,
    'periodo_id': periodoId,
    'gasto_nombre': gastoNombre,
    'gasto_monto': gastoMonto,
    'gasto_fecha': gastoFecha?.toIso8601String(),
    'gasto_frecuencia': gastoFrecuencia,
    'inicio_recurrencia': inicioRecurrencia?.toIso8601String(),
    'fin_recurrencia': finRecurrencia?.toIso8601String(),
  };
}
