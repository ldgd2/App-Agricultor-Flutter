// lib/screens/ofertas_screen.dart

import 'package:flutter/material.dart';
import 'package:agro_link/models/Agricultor/oferta.dart';
import 'package:agro_link/services/api_service.dart';
import 'package:agro_link/screen/Agricultor/add_oferta_screen.dart';

class OfertasScreen extends StatefulWidget {
  const OfertasScreen({super.key});

  @override
  OfertasScreenState createState() => OfertasScreenState();
}

class OfertasScreenState extends State<OfertasScreen> {
  final ApiService apiService = ApiService();
  List<Oferta> ofertas = [];

  @override
  void initState() {
    super.initState();
    _fetchOfertas();
  }

 Future<void> _fetchOfertas() async {
  try {
    final data = await apiService.fetchOfertas();
   // print(data); // <-- Esto imprimirá el JSON que se recibe de la API
    setState(() {
      ofertas = data.map((ofertaData) => Oferta.fromJson(ofertaData)).toList();
    });
  } catch (e) {
    debugPrint('Error al cargar ofertas: $e');
  }
}


  void _addOferta(Oferta oferta) {
    setState(() {
      ofertas.add(oferta);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ofertas'),
        backgroundColor: Colors.green.shade400,
      ),
      body: ListView.builder(
        itemCount: ofertas.length,
        itemBuilder: (context, index) {
          final oferta = ofertas[index];
          return ListTile(
            title: Text('Producción ID: ${oferta.idProduccion}'),
            subtitle: Text('Precio: ${oferta.precioOferta}, Cantidad: ${oferta.cantidadOferta}, Unidad de Peso: ${oferta.idUnidadPeso}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade400,
        onPressed: () async {
          final newOferta = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddOfertaScreen(onSave: _addOferta),
            ),
          );
          if (newOferta != null) {
            _fetchOfertas();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
