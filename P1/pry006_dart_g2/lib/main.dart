import 'package:flutter/material.dart';
import 'pantallas/menu_pantalla.dart';
import 'pantallas/vehiculos_pantalla.dart';
import 'pantallas/banco_pantalla.dart';
import 'pantallas/ahorro_pantalla.dart';
import 'pantallas/adivinar_pantalla.dart';
import 'pantallas/intervalo_pantalla.dart';

void main() => runApp(const EjerciciosApp());

class EjerciciosApp extends StatelessWidget {
  const EjerciciosApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Ejercicios NRC 36873',
    theme: ThemeData(colorSchemeSeed: Colors.teal),
    initialRoute: '/',
    routes: {
      '/': (_) => const MenuPantalla(),
      '/vehiculos': (_) => const VehiculosPantalla(),
      '/banco': (_) => const BancoPantalla(),
      '/ahorro': (_) => const AhorroPantalla(),
      '/adivinar': (_) => const AdivinarPantalla(),
      '/intervalo': (_) => const IntervaloPantalla(),
    },
  );
}
