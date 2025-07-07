class Categoria {
  final int categoriaId;
  final String categoriaNom;
  final String? categoriaDescrip;

  Categoria({
    required this.categoriaId,
    required this.categoriaNom,
    this.categoriaDescrip,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
    categoriaId: json['categoria_id'],
    categoriaNom: json['categoria_nom'],
    categoriaDescrip: json['categoria_descrip'],
  );

  Map<String, dynamic> toJson() => {
    'categoria_id': categoriaId,
    'categoria_nom': categoriaNom,
    'categoria_descrip': categoriaDescrip,
  };
}
