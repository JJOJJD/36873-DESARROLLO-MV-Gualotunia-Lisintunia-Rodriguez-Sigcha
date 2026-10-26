import 'package:flutter/material.dart';
import 'tema/tema_app.dart';
import 'vista/pantallas/login_pantalla.dart';
import 'vista/pantallas/consumo_pantalla.dart';

void main() {
  runApp(const AguaPotableApp());
}

class AguaPotableApp extends StatelessWidget {
  const AguaPotableApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Servicio de Agua Potable',
      debugShowCheckedModeBanner: false,
      theme: TemaApp.tema,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPantalla(),
        '/login': (context) => const LoginPantalla(),
        '/consumo': (context) => const ConsumoPantalla(),
      },
    );
  }
}
