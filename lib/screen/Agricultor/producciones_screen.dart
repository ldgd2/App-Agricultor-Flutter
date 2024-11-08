// lib/screens/producciones_screen.dart

import 'package:flutter/material.dart';
import 'package:agro_link/models/agricultor/produccion.dart';
import 'package:agro_link/services/api_service.dart';
import 'package:agro_link/screen/agricultor/add_produccion_screen.dart'; // Asegúrate de que solo esté esta importación


class ProduccionesScreen extends StatefulWidget {
  final int idAgricultor; // Nuevo parámetro para el ID del agricultor

  const ProduccionesScreen({Key? key, required this.idAgricultor}) : super(key: key);

  @override
  ProduccionesScreenState createState() => ProduccionesScreenState();
}

class ProduccionesScreenState extends State<ProduccionesScreen> {
  final ApiService apiService = ApiService();
  List<Produccion> producciones = [];

  @override
  void initState() {
    super.initState();
    _fetchProducciones(); // Llamada para cargar las producciones filtradas
  }

  Future<void> _fetchProducciones() async {
    try {
      // Llamada a la API para obtener producciones filtradas por idAgricultor
      final data = await apiService.fetchProduccionesByAgricultor(widget.idAgricultor);
      setState(() {
        producciones = data.map((prodData) => Produccion.fromJson(prodData)).toList();
      });
    } catch (e) {
      debugPrint('Error al cargar producciones: $e');
    }
  }

  void _addProduccion(Produccion produccion) {
    setState(() {
      producciones.add(produccion);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Producciones'),
        backgroundColor: Colors.green.shade400,
      ),
      body: ListView.builder(
        itemCount: producciones.length,
        itemBuilder: (context, index) {
          final produccion = producciones[index];
          return ListTile(
            title: Text('Producción ID: ${produccion.id}'),
            subtitle: Text('Cantidad Disponible: ${produccion.cantidadDisponible}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade400,
        onPressed: () async {
          final newProduccion = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProduccionScreen(onSave: _addProduccion),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
