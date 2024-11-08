import 'package:flutter/material.dart';
import 'package:agro_link/models/agricultor/produccion.dart';
import 'package:agro_link/services/api_service.dart';

class AddProduccionScreen extends StatefulWidget {
  final void Function(Produccion) onSave;

  const AddProduccionScreen({super.key, required this.onSave});

  @override
  AddProduccionScreenState createState() => AddProduccionScreenState();
}

class AddProduccionScreenState extends State<AddProduccionScreen> {
  final TextEditingController _idTerrenoController = TextEditingController();
  final TextEditingController _idTemporadaController = TextEditingController();
  final TextEditingController _idProductoController = TextEditingController();
  final TextEditingController _cantidadDisponibleController = TextEditingController();
  final TextEditingController _fechaRecoleccionController = TextEditingController();
  final ApiService apiService = ApiService();

  // Opciones de peso usando Map
  final Map<int, String> pesoUnidad = {
    1: "Kilos",
    2: "Gramos",
    3: "Toneladas"
  };

  // Variable para almacenar el id_peso seleccionado
  int? _selectedPesoId;

  void _saveProduccion() async {
    final idTerreno = int.tryParse(_idTerrenoController.text.trim());
    final idTemporada = int.tryParse(_idTemporadaController.text.trim());
    final idProducto = int.tryParse(_idProductoController.text.trim());
    final cantidadDisponible = double.tryParse(_cantidadDisponibleController.text.trim());
    final fechaRecoleccion = _fechaRecoleccionController.text.trim();

    if (idTerreno != null &&
        idTemporada != null &&
        idProducto != null &&
        cantidadDisponible != null &&
        fechaRecoleccion.isNotEmpty &&
        _selectedPesoId != null) {
      final produccionData = {
        'id_terreno': idTerreno,
        'id_temporada': idTemporada,
        'id_producto': idProducto,
        'cantidad_disponible': cantidadDisponible,
        'fecha_recoleccion': fechaRecoleccion,
        'id_unidad_peso': _selectedPesoId,
      };

      try {
        await apiService.createProduccion(produccionData);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Producción creada con éxito')),
        );
        widget.onSave(Produccion(
          idTerreno: idTerreno,
          idTemporada: idTemporada,
          idProducto: idProducto,
          cantidadDisponible: cantidadDisponible,
          fechaRecoleccion: fechaRecoleccion,
          pesoUnidad: {_selectedPesoId!: pesoUnidad[_selectedPesoId]!},
        ));
        Navigator.pop(context);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al crear la producción')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _fechaRecoleccionController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Producción'),
        backgroundColor: Colors.green.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idTerrenoController,
              decoration: const InputDecoration(labelText: 'ID de Terreno'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _idTemporadaController,
              decoration: const InputDecoration(labelText: 'ID de Temporada'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _idProductoController,
              decoration: const InputDecoration(labelText: 'ID de Producto'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _cantidadDisponibleController,
              decoration: const InputDecoration(labelText: 'Cantidad Disponible'),
              keyboardType: TextInputType.number,
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: _fechaRecoleccionController,
                  decoration: const InputDecoration(labelText: 'Fecha de Recolección (YYYY-MM-DD)'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Dropdown para seleccionar la unidad de peso
            DropdownButton<int>(
              hint: const Text("Seleccionar Unidad de Peso"),
              isExpanded: true,
              value: _selectedPesoId,
              items: pesoUnidad.entries.map((entry) {
                return DropdownMenuItem<int>(
                  value: entry.key,
                  child: Text(entry.value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedPesoId = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProduccion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
