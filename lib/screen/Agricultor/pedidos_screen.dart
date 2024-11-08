import 'package:flutter/material.dart';
import 'package:agro_link/models/Agricultor/pedido.dart';
import 'package:agro_link/services/api_service.dart';
import 'package:agro_link/screen/Agricultor/add_pedido_screen.dart';

class PedidosScreen extends StatefulWidget {
  const PedidosScreen({Key? key}) : super(key: key);

  @override
  PedidosScreenState createState() => PedidosScreenState();
}

class PedidosScreenState extends State<PedidosScreen> {
  final ApiService apiService = ApiService();
  List<Pedido> pedidos = [];

  @override
  void initState() {
    super.initState();
    _fetchPedidos();
  }

  Future<void> _fetchPedidos() async {
    try {
      final data = await apiService.fetchPedidos();
      setState(() {
        pedidos = data.map((pedidoData) => Pedido.fromJson(pedidoData)).toList();
      });
    } catch (e) {
      debugPrint('Error al cargar pedidos: $e');
    }
  }

  void _addPedido(Pedido pedido) {
    setState(() {
      pedidos.add(pedido);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        backgroundColor: Colors.green.shade400,
      ),
      body: ListView.builder(
        itemCount: pedidos.length,
        itemBuilder: (context, index) {
          final pedido = pedidos[index];
          return ExpansionTile(
            title: Text('Pedido ID Cliente: ${pedido.idCliente}'),
            children: pedido.productos.map((producto) {
              return ListTile(
                title: Text('ID Producto: ${producto.idProducto}'),
                subtitle: Text('Cantidad: ${producto.cantidad}, Unidad de Peso: ${producto.idUnidadPeso}'),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade400,
        onPressed: () async {
          final newPedido = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPedidoScreen(onSave: _addPedido), // Cambia 'addPedido' por '_addPedido'
            ),
          );
          if (newPedido != null) {
            _fetchPedidos();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
