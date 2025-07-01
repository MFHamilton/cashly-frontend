class Metas {
  final int metaId;
  final int usuarioId;
  final int? categoriaId;
  final int periodoId;
  final String metaNombre;
  final String? metaDescripcion;
  final double metaMontoInicial;
  final double? metaMontoUlt;
  final bool metaEsActivo;
  final DateTime? metaFechaInicio;
  final DateTime? metaFechaFin;

  Metas({
    required this.metaId,
    required this.usuarioId,
    this.categoriaId,
    required this.periodoId,
    required this.metaNombre,
    this.metaDescripcion,
    required this.metaMontoInicial,
    this.metaMontoUlt,
    required this.metaEsActivo,
    this.metaFechaInicio,
    this.metaFechaFin,
  });

  factory Metas.fromJson(Map<String, dynamic> json) => Metas(
    metaId: json['meta_id'],
    usuarioId: json['usuario_id'],
    categoriaId: json['categoria_id'],
    periodoId: json['periodo_id'],
    metaNombre: json['meta_nombre'],
    metaDescripcion: json['meta_descripcion'],
    metaMontoInicial: (json['meta_monto_inicial'] as num).toDouble(),
    metaMontoUlt: json['meta_monto_ult'] == null
        ? null
        : (json['meta_monto_ult'] as num).toDouble(),
    metaEsActivo: json['meta_es_activo'],
    metaFechaInicio: json['meta_fecha_inicio'] == null
        ? null
        : DateTime.parse(json['meta_fecha_inicio']),
    metaFechaFin: json['meta_fecha_fin'] == null
        ? null
        : DateTime.parse(json['meta_fecha_fin']),
  );

  Map<String, dynamic> toJson() => {
    'meta_id': metaId,
    'usuario_id': usuarioId,
    'categoria_id': categoriaId,
    'periodo_id': periodoId,
    'meta_nombre': metaNombre,
    'meta_descripcion': metaDescripcion,
    'meta_monto_inicial': metaMontoInicial,
    'meta_monto_ult': metaMontoUlt,
    'meta_es_activo': metaEsActivo,
    'meta_fecha_inicio': metaFechaInicio?.toIso8601String(),
    'meta_fecha_fin': metaFechaFin?.toIso8601String(),
  };
}
