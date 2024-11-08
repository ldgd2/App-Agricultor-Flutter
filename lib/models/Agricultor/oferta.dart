class Oferta {
  final int? id;
  final int idProduccion;
  final int idAgricultor;
  final double precioOferta;
  final double cantidadOferta; // Cambiamos a double
  final int idUnidadPeso;

  Oferta({
    this.id,
    required this.idProduccion,
    required this.idAgricultor,
    required this.precioOferta,
    required this.cantidadOferta,
    required this.idUnidadPeso,
  });

  factory Oferta.fromJson(Map<String, dynamic> json) {
    return Oferta(
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      idProduccion: json['id_produccion'] is String
          ? int.tryParse(json['id_produccion']) ?? 0
          : json['id_produccion'] ?? 0,
      idAgricultor: json['id_agricultor'] is String
          ? int.tryParse(json['id_agricultor']) ?? 0
          : json['id_agricultor'] ?? 0,
      precioOferta: json['precio_oferta'] is String
          ? double.tryParse(json['precio_oferta']) ?? 0.0
          : (json['precio_oferta'] as num).toDouble(),
      cantidadOferta: json['cantidad_oferta'] is String
          ? double.tryParse(json['cantidad_oferta']) ?? 0.0 // Maneja como double
          : (json['cantidad_oferta'] as num).toDouble(), // Maneja como double
      idUnidadPeso: json['id_unidad_peso'] is String
          ? int.tryParse(json['id_unidad_peso']) ?? 0
          : json['id_unidad_peso'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_produccion': idProduccion,
      'id_agricultor': idAgricultor,
      'precio_oferta': precioOferta,
      'cantidad_oferta': cantidadOferta,
      'id_unidad_peso': idUnidadPeso,
    };
  }
}
