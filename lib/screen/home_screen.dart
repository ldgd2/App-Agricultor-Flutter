// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:agro_link/services/api_service.dart';
import 'package:agro_link/cultivos/land.dart';
import 'add_land_screen.dart';

class HomeScreen extends StatefulWidget {
  final int idAgricultor;

  const HomeScreen({Key? key, required this.idAgricultor}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  List<Land> lands = [];
  List<Land> filteredLands = [];
  String agricultorName = '';
  int currentPage = 0;
  int pageSize = 5;
  String searchQuery = '';
  String sortBy = 'Área';
  bool ascending = true;

  @override
  void initState() {
    super.initState();
    _fetchAgricultorName();
    _fetchLands();
  }

  Future<void> _fetchAgricultorName() async {
    try {
      final agricultores = await apiService.fetchAgricultores();
      final agricultor = agricultores.firstWhere(
        (ag) => ag['id'] == widget.idAgricultor,
        orElse: () => null,
      );
      if (agricultor != null) {
        setState(() {
          agricultorName = agricultor['nombre'];
        });
      } else {
        setState(() {
          agricultorName = 'Agricultor no encontrado';
        });
      }
    } catch (e) {
      setState(() {
        agricultorName = 'Error al cargar agricultor';
      });
    }
  }

  Future<void> _fetchLands() async {
    try {
      final data = await apiService.fetchLands(widget.idAgricultor);
      setState(() {
        lands = data.map((landData) => Land.fromJson(landData)).toList();
        _applyFilters();
      });
    } catch (e) {
      print('Error al cargar terrenos: $e');
    }
  }

  void _applyFilters() {
    setState(() {
      filteredLands = lands.where((land) {
        return land.descripcion.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();

      if (sortBy == 'Área') {
        filteredLands.sort((a, b) => ascending ? a.area.compareTo(b.area) : b.area.compareTo(a.area));
      } else if (sortBy == 'Superficie Total') {
        filteredLands.sort((a, b) => ascending ? a.superficieTotal.compareTo(b.superficieTotal) : b.superficieTotal.compareTo(a.superficieTotal));
      }
    });
  }

  List<Land> get paginatedLands {
    int start = currentPage * pageSize;
    int end = start + pageSize;
    return filteredLands.sublist(start, end > filteredLands.length ? filteredLands.length : end);
  }

  void _onPageChanged(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AgroLink - Bienvenido, $agricultorName'),
        backgroundColor: Colors.green.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  _applyFilters();
                });
              },
              decoration: InputDecoration(
                labelText: 'Buscar terreno...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: sortBy,
                  items: ['Área', 'Superficie Total']
                      .map((label) => DropdownMenuItem(child: Text(label), value: label))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      sortBy = value!;
                      _applyFilters();
                    });
                  },
                ),
                IconButton(
                  icon: Icon(ascending ? Icons.arrow_upward : Icons.arrow_downward),
                  onPressed: () {
                    setState(() {
                      ascending = !ascending;
                      _applyFilters();
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: paginatedLands.length,
                itemBuilder: (context, index) {
                  final land = paginatedLands[index];
                  return _buildLandItem(land);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                (filteredLands.length / pageSize).ceil(),
                (index) => IconButton(
                  icon: Icon(Icons.circle, color: index == currentPage ? Colors.green : Colors.grey),
                  onPressed: () => _onPageChanged(index),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade400,
        onPressed: () async {
          final newLand = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddLandScreen(
                idAgricultor: widget.idAgricultor,
                onSave: (land) {
                  setState(() {
                    lands.insert(0, land);
                    _applyFilters();
                  });
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildLandItem(Land land) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text('ID: ${land.idAgricultor}, Área: ${land.area} ha'),
        subtitle: Text(land.descripcion),
        trailing: Text(
          'Superficie Total: ${land.superficieTotal} ha',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
