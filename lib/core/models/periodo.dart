class Periodo {
  final int periodoId;
  final String? periodoNom;

  Periodo({
    required this.periodoId,
    this.periodoNom,
  });

  factory Periodo.fromJson(Map<String, dynamic> json) => Periodo(
    periodoId: json['periodo_id'],
    periodoNom: json['periodo_nom'],
  );

  Map<String, dynamic> toJson() => {
    'periodo_id': periodoId,
    'periodo_nom': periodoNom,
  };
}
