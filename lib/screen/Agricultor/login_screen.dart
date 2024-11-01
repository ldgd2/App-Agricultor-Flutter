import 'package:flutter/material.dart';
import 'package:agro_link/screen/home_screen.dart';
import 'package:agro_link/screen/Agricultor/singup_screen.dart'; // Asegúrate de importar la pantalla de registro

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();

  void _login() {
    // Verifica que el campo no esté vacío y convierte el ID a un número entero
    int? idAgricultor = int.tryParse(_idController.text);
    if (idAgricultor != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(idAgricultor: idAgricultor),
        ),
      );
    } else {
      // Muestra un mensaje de error si el ID no es válido
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, ingresa un ID válido.')),
      );
    }
  }

  void _goToRegister() {
    // Navega a la pantalla de registro
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inicio de Sesión")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: "ID de Agricultor",
                  hintText: "Ingresa tu ID",
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text("Iniciar Sesión"),
              ),
              SizedBox(height: 10), // Espacio entre los botones
              OutlinedButton(
                onPressed: _goToRegister,
                child: Text("Registrarse"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
