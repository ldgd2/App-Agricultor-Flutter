// lib/models/pedido.dart

class Pedido {
  final int idCliente;
  final List<ProductoPedido> productos;

  Pedido({
    required this.idCliente,
    required this.productos,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      idCliente: json['id_cliente'],
      productos: json['productos'] != null
          ? (json['productos'] as List)
              .map((producto) => ProductoPedido.fromJson(producto))
              .toList()
          : [], // Si es null, asigna una lista vacía
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_cliente': idCliente,
      'productos': productos.map((producto) => producto.toJson()).toList(),
    };
  }
}

class ProductoPedido {
  final int idProducto;
  final double cantidad;
  final int idUnidadPeso;

  ProductoPedido({
    required this.idProducto,
    required this.cantidad,
    required this.idUnidadPeso,
  });

  factory ProductoPedido.fromJson(Map<String, dynamic> json) {
    return ProductoPedido(
      idProducto: json['id_producto'],
      cantidad: json['cantidad'],
      idUnidadPeso: json['id_unidad_peso'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_producto': idProducto,
      'cantidad': cantidad,
      'id_unidad_peso': idUnidadPeso,
    };
  }
}
