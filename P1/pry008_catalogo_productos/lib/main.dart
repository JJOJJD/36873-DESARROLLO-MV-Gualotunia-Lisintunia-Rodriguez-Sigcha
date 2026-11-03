import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_model/catalogo_viewmodel.dart';
import 'view/pantallas/splash_pantalla.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CatalogoViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TecnoTienda - Catálogo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPantalla(),
      },
    );
  }
}
