// lib/screens/add_pedido_screen.dart

import 'package:flutter/material.dart';
import 'package:agro_link/models/Agricultor/pedido.dart';
import 'package:agro_link/services/api_service.dart';

class AddPedidoScreen extends StatefulWidget {
  final Function(Pedido) onSave;

  const AddPedidoScreen({Key? key, required this.onSave}) : super(key: key);

  @override
  AddPedidoScreenState createState() => AddPedidoScreenState();
}

class AddPedidoScreenState extends State<AddPedidoScreen> {
  final TextEditingController _idClienteController = TextEditingController();
  final ApiService apiService = ApiService();
  final List<ProductoPedido> _productos = [];

  void _addProductoField() {
    setState(() {
      _productos.add(ProductoPedido(idProducto: 0, cantidad: 0, idUnidadPeso: 1));
    });
  }

  void _removeProductoField(int index) {
    setState(() {
      _productos.removeAt(index);
    });
  }

  void _savePedido() async {
    final idCliente = int.tryParse(_idClienteController.text.trim());

    if (idCliente != null && _productos.isNotEmpty) {
      final pedidoData = Pedido(idCliente: idCliente, productos: _productos);
      try {
        await apiService.createPedido(pedidoData.toJson());
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pedido creado con éxito')),
        );
        widget.onSave(pedidoData);
        Navigator.pop(context);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear el pedido: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos y añade al menos un producto.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Pedido'),
        backgroundColor: Colors.green.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idClienteController,
              decoration: const InputDecoration(labelText: 'ID de Cliente'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _productos.length,
                itemBuilder: (context, index) {
                  final producto = _productos[index];
                  return Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(labelText: 'ID de Producto ${index + 1}'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _productos[index] = ProductoPedido(
                              idProducto: int.tryParse(value) ?? 0,
                              cantidad: producto.cantidad,
                              idUnidadPeso: producto.idUnidadPeso,
                            );
                          });
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Cantidad del Producto ${index + 1}'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _productos[index] = ProductoPedido(
                              idProducto: producto.idProducto,
                              cantidad: double.tryParse(value) ?? 0,
                              idUnidadPeso: producto.idUnidadPeso,
                            );
                          });
                        },
                      ),
                      DropdownButton<int>(
                        hint: const Text("Seleccionar Unidad de Peso"),
                        isExpanded: true,
                        value: producto.idUnidadPeso,
                        items: const [
                          DropdownMenuItem(value: 1, child: Text("Kilos")),
                          DropdownMenuItem(value: 2, child: Text("Gramos")),
                          DropdownMenuItem(value: 3, child: Text("Toneladas")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _productos[index] = ProductoPedido(
                              idProducto: producto.idProducto,
                              cantidad: producto.cantidad,
                              idUnidadPeso: value ?? 1,
                            );
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () => _removeProductoField(index),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _addProductoField,
              child: const Text("Añadir Producto"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _savePedido,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Guardar Pedido'),
            ),
          ],
        ),
      ),
    );
  }
}
