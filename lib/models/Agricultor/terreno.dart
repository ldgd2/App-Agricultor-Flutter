// lib/models/terreno.dart

class Terreno {
  final int? id;
  final int idAgricultor;
  final double ubicacionLatitud;
  final double ubicacionLongitud;
  final String ubicacion;
  final double area;
  final double superficieTotal;
  final String descripcion;

  Terreno({
    this.id,
    required this.idAgricultor,
    required this.ubicacionLatitud,
    required this.ubicacionLongitud,
    required this.ubicacion,
    required this.area,
    required this.superficieTotal,
    required this.descripcion,
  });

  // Método para crear una instancia de Terreno a partir de JSON
  factory Terreno.fromJson(Map<String, dynamic> json) {
    return Terreno(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      idAgricultor: int.tryParse(json['id_agricultor'].toString()) ?? 0,
      ubicacionLatitud: double.tryParse(json['ubicacion_latitud'].toString()) ?? 0.0,
      ubicacionLongitud: double.tryParse(json['ubicacion_longitud'].toString()) ?? 0.0,
      ubicacion: json['ubicacion'] ?? '',  // Asignar cadena vacía si es null
      area: double.tryParse(json['area'].toString()) ?? 0.0,
      superficieTotal: double.tryParse(json['superficie_total'].toString()) ?? 0.0,
      descripcion: json['descripcion'] ?? '',  // Asignar cadena vacía si es null
    );
  }

  // Método para convertir Terreno a JSON
  Map<String, dynamic> toJson() {
    return {
      'id_agricultor': idAgricultor,
      'ubicacion_latitud': ubicacionLatitud,
      'ubicacion_longitud': ubicacionLongitud,
      'ubicacion': ubicacion,
      'area': area,
      'superficie_total': superficieTotal,
      'descripcion': descripcion,
    };
  }
}
