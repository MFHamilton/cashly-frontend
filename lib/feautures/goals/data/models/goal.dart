class GoalModel {
  final int metaId;
  final int usuarioId;
  final int? categoriaId;
  final String? categoriaNom;
  final int periodoId;
  final String metaNombre;
  final String? metaDescripcion;
  final double metaMontoInicial;
  final double? metaMontoUlt;
  final DateTime? fechaInicio;
  final DateTime? fechaFin;

  const GoalModel({
    required this.metaId,
    required this.usuarioId,
    this.categoriaId,
    this.categoriaNom,
    required this.periodoId,
    required this.metaNombre,
    this.metaDescripcion,
    required this.metaMontoInicial,
    this.metaMontoUlt,
    this.fechaInicio,
    this.fechaFin,
  });

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      metaId: json['meta_id'],
      usuarioId: json['usuario_id'],
      categoriaId: json['categoria_id'],
      categoriaNom:
          json['categoria_nom'] != null
              ? json['categoria_nom'].toString()
              : 'Sin categoría',
      periodoId: json['periodo_id'],
      metaNombre: json['meta_nombre'],
      metaDescripcion: json['meta_descripcion'] ?? '',
      metaMontoInicial: double.parse(json['meta_monto_inicial'].toString()),
      metaMontoUlt:
          json['meta_monto_ult'] != null
              ? double.parse(json['meta_monto_ult'].toString())
              : 0.0,
      fechaInicio:
          json['meta_fecha_inicio'] != null
              ? DateTime.parse(json['meta_fecha_inicio'])
              : null,
      fechaFin:
          json['meta_fecha_fin'] != null
              ? DateTime.parse(json['meta_fecha_fin'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meta_id': metaId,
      'usuario_id': usuarioId,
      'categoria_id': categoriaId,
      'categoria_nom': categoriaNom,
      'periodo_id': periodoId,
      'meta_nombre': metaNombre,
      'meta_descripcion': metaDescripcion,
      'meta_monto_inicial': metaMontoInicial.toStringAsFixed(2),
      'meta_monto_ult': metaMontoUlt?.toStringAsFixed(2),
      'meta_fecha_inicio': fechaInicio?.toIso8601String(),
      'meta_fecha_fin': fechaFin?.toIso8601String(),
    };
  }
}
