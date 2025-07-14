

class Categoria {
  final int categoriaId;
  final String categoriaNom;
  final String? categoriaDescrip;
  final int? ownerId;
  final String iconRef;

  Categoria({
    required this.categoriaId,
    required this.categoriaNom,
    this.categoriaDescrip,
    this.ownerId,
    required this.iconRef,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
    categoriaId: json['categoria_id'],
    categoriaNom: json['categoria_nom'],
    categoriaDescrip: json['categoria_descrip'],
    ownerId: json["owner_id"],
    iconRef: json['icon_ref'],
  );

  Map<String, dynamic> toJson() => {
    'categoria_id': categoriaId,
    'categoria_nom': categoriaNom,
    'categoria_descrip': categoriaDescrip,
    'owner_id': ownerId,
    'icon_ref': iconRef,
  };


}
