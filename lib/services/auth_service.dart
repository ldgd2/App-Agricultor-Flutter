import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:agro_link/models/Agricultor/agricultor.dart';

class AuthService {
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  // Registro de nuevo agricultor
  Future<void> registerAgricultor(Agricultor agricultor) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/agricultores'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(agricultor.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al crear la cuenta de agricultor');
    }
  }

   // Método de inicio de sesión
  Future<void> login(String email) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email}),
    );

    if (response.statusCode == 200) {
      // Inicio de sesión exitoso
      final data = json.decode(response.body);
      // Guardar token o manejar la sesión según el backend
    } else if (response.statusCode == 404) {
      // Manejar el caso de "Usuario no encontrado"
      throw Exception('El usuario no está registrado.');
    } else {
      // Otros errores de inicio de sesión
      throw Exception('Error al iniciar sesión');
    }
  }
}
