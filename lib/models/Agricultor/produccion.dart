// lib/models/produccion.dart

class Produccion {
  final int? id;
  final int idTerreno;
  final int idTemporada;
  final int idProducto;
  final double cantidadDisponible;
  final String fechaRecoleccion;
  final Map<int, String> pesoUnidad;

  Produccion({
    this.id,
    required this.idTerreno,
    required this.idTemporada,
    required this.idProducto,
    required this.cantidadDisponible,
    required this.fechaRecoleccion,
    required this.pesoUnidad,
  });

  factory Produccion.fromJson(Map<String, dynamic> json) {
    return Produccion(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      idTerreno: int.tryParse(json['id_terreno'].toString()) ?? 0,
      idTemporada: int.tryParse(json['id_temporada'].toString()) ?? 0,
      idProducto: int.tryParse(json['id_producto'].toString()) ?? 0,
      cantidadDisponible: double.tryParse(json['cantidad_disponible'].toString()) ?? 0,
      fechaRecoleccion: json['fecha_recoleccion'] ?? '',
      pesoUnidad: {
        int.tryParse(json['id_unidad_peso'].toString()) ?? 0: "Unidad no especificada"
      },
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_terreno': idTerreno,
      'id_temporada': idTemporada,
      'id_producto': idProducto,
      'cantidad_disponible': cantidadDisponible,
      'fecha_recoleccion': fechaRecoleccion,
      'id_unidad_peso': pesoUnidad.keys.first,
    };
  }
}
