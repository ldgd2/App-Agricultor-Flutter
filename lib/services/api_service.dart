// lib/services/api_service.dart

import 'dart:convert';
import 'package:agro_link/config/config.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String url_service_api = url_api;

  // 1. Agricultores
  Future<List<dynamic>> fetchAgricultores() async {
    final response = await http.get(Uri.parse('$url_service_api/agricultores'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los agricultores');
    }
  }

  Future<String> createAgricultor(Map<String, dynamic> agricultorData) async {
    final response = await http.post(
      Uri.parse('$url_service_api/agricultores'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(agricultorData),
    );
    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      return data['id'].toString();
    } else {
      throw Exception('Error al crear el agricultor');
    }
  }

  // 2. Categorías
  Future<List<dynamic>> fetchCategorias() async {
    final response = await http.get(Uri.parse('$url_service_api/categorias'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar las categorías');
    }
  }

  Future<void> createCategoria(Map<String, dynamic> categoriaData) async {
    final response = await http.post(
      Uri.parse('$url_service_api/categorias'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(categoriaData),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear la categoría');
    }
  }

  // 3. Clientes
  Future<List<dynamic>> fetchClientes() async {
    final response = await http.get(Uri.parse('$url_service_api/clientes'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los clientes');
    }
  }

  Future<void> createCliente(Map<String, dynamic> clienteData) async {
    final response = await http.post(
      Uri.parse('$url_service_api/clientes'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(clienteData),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear el cliente');
    }
  }

  // 4. Productos
  Future<List<dynamic>> fetchProductos() async {
    final response = await http.get(Uri.parse('$url_service_api/productos'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los productos');
    }
  }

  Future<void> createProducto(Map<String, dynamic> productoData) async {
    final response = await http.post(
      Uri.parse('$url_service_api/productos'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(productoData),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear el producto');
    }
  }

  // 5. Producciones
  Future<List<dynamic>> fetchProducciones() async {
    final response = await http.get(Uri.parse('$url_service_api/producciones'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar las producciones');
    }
  }

   // Método para obtener producciones por agricultor
  Future<List<dynamic>> fetchProduccionesByAgricultor(int idAgricultor) async {
    final response = await http.get(Uri.parse('$url_service_api/producciones?agricultor_id=$idAgricultor'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar las producciones');
    }
  }

  Future<void> createProduccion(Map<String, dynamic> produccionData) async {
    final response = await http.post(
      Uri.parse('$url_service_api/producciones'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(produccionData),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear la producción');
    }
  }

  // 6. Pedidos
  Future<List<dynamic>> fetchPedidos() async {
    final response = await http.get(Uri.parse('$url_service_api/pedidos'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los pedidos');
    }
  }

  Future<void> createPedido(Map<String, dynamic> pedidoData) async {
    final response = await http.post(
      Uri.parse('$url_service_api/pedidos'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pedidoData),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear el pedido');
    }
  }

  // 7. Detalles de Pedido
  Future<List<dynamic>> fetchPedidoDetalles() async {
    final response = await http.get(Uri.parse('$url_service_api/pedido-detalles'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los detalles de pedidos');
    }
  }

  Future<void> createPedidoDetalle(Map<String, dynamic> detalleData) async {
    final response = await http.post(
      Uri.parse('$url_service_api/pedido-detalles'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(detalleData),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear el detalle de pedido');
    }
  }

  // 8. Ofertas
  Future<List<dynamic>> fetchOfertas() async {
    final response = await http.get(Uri.parse('$url_service_api/ofertas'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar las ofertas');
    }
  }

  Future<void> createOferta(Map<String, dynamic> ofertaData) async {
    final response = await http.post(
      Uri.parse('$url_service_api/ofertas'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(ofertaData),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear la oferta');
    }
  }

  // 9. Terrenos (Lands)
  Future<List<dynamic>> fetchTerrenos(int idAgricultor) async {
    final response = await http.get(Uri.parse('$url_service_api/terrenos?agricultor_id=$idAgricultor'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los terrenos');
    }
  }

  Future<void> createTerreno(Map<String, dynamic> terrenoData) async {
    final response = await http.post(
      Uri.parse('$url_service_api/terrenos'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(terrenoData),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear el terreno');
    }
  }

  // 10. Búsqueda de Agricultores por ID
  Future<List<Map<String, dynamic>>> searchAgricultores() async {
    final response = await http.get(Uri.parse('$url_service_api/agricultores'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Error al cargar los agricultores');
    }
  }
}
