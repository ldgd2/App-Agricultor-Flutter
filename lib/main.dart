import 'package:flutter/material.dart';
import 'package:agro_link/screen/agricultor/login_screen.dart';
import 'package:agro_link/screen/agricultor/singup_screen.dart';
import 'package:agro_link/screen/add_land_screen.dart';
import 'package:agro_link/screen/home_screen.dart';

void main() {
  runApp(AgroLinkApp());
}

class AgroLinkApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agro Link',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.greenAccent, // Color principal
        hintColor: Colors.greenAccent,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => SignUpScreen(),
       //
      // '/home': (context) => HomeScreen(),
      },
    );
  }
}
