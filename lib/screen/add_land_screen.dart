// lib/screens/add_land_screen.dart

import 'package:flutter/material.dart';
import 'package:agro_link/cultivos/land.dart';
import 'package:agro_link/services/api_service.dart';

class AddLandScreen extends StatefulWidget {
  final int idAgricultor;
  final Function(Land) onSave;

  const AddLandScreen({required this.idAgricultor, required this.onSave, Key? key}) : super(key: key);

  @override
  _AddLandScreenState createState() => _AddLandScreenState();
}

class _AddLandScreenState extends State<AddLandScreen> {
  final TextEditingController latitudController = TextEditingController();
  final TextEditingController longitudController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController superficieTotalController = TextEditingController();
   final TextEditingController ubicacionController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final ApiService _apiService = ApiService();

  void saveLand() async {
    final ubicacionLatitud = double.tryParse(latitudController.text) ?? 0.0;
    final ubicacionLongitud = double.tryParse(longitudController.text) ?? 0.0;
    final area = double.tryParse(areaController.text) ?? 0.0;
    final superficieTotal = double.tryParse(superficieTotalController.text) ?? 0.0;
    final ubicacion = ubicacionController.text;
    final descripcion = descripcionController.text;

    if (ubicacionLatitud != 0.0 &&
        ubicacionLongitud != 0.0 &&
        area > 0 &&
        superficieTotal > 0 &&
        descripcion.isNotEmpty) {
      final landData = {
        'id_agricultor': widget.idAgricultor,

        'ubicacion_latitud': ubicacionLatitud,
        'ubicacion_longitud': ubicacionLongitud,
        'ubicacion': ubicacion,
        'area': area,
        'superficie_total': superficieTotal,
        'descripcion': descripcion,
      };

      try {
        await _apiService.createLand(landData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terreno añadido con éxito')),
        );
        widget.onSave(Land.fromJson(landData));
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al añadir el terreno')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos correctamente.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Terreno'),
        backgroundColor: Colors.green.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(latitudController, 'Latitud de Ubicación', Icons.location_on, isNumeric: true),
            _buildTextField(longitudController, 'Longitud de Ubicación', Icons.location_on, isNumeric: true),
            _buildTextField(areaController, 'Área (ha)', Icons.square_foot, isNumeric: true),
            _buildTextField(superficieTotalController, 'Superficie Total (ha)', Icons.square_foot, isNumeric: true),
            _buildTextField(ubicacionController, 'ubicacion', Icons.map_sharp),
            _buildTextField(descripcionController, 'Descripción', Icons.description),
            Spacer(),
            ElevatedButton(
              onPressed: saveLand,
              child: Text('Añadir Terreno', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade400,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isNumeric = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green.shade400),
        filled: true,
        fillColor: const Color.fromARGB(255, 1, 17, 2),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }
}
