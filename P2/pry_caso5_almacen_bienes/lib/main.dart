import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/datasources/almacen_api_datasource.dart';
import 'data/repositories/almacen_repository_impl.dart';
import 'domain/usecases/gestionar_almacen_usecases.dart';
import 'presentation/viewmodels/almacen_viewmodel.dart';
import 'routes/app_routes.dart';

void main() {
  final datasource = AlmacenApiDatasource();
  final repository = AlmacenRepositoryImpl(datasource);
  final useCases = GestionarAlmacenUseCases(repository);

  runApp(
    ChangeNotifierProvider(
      create: (_) => AlmacenViewModel(useCases),
      child: const GuardaAlmacenApp(),
    ),
  );
}

class GuardaAlmacenApp extends StatelessWidget {
  const GuardaAlmacenApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1E3A5F);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guarda de Almacén - Caso 5',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F6F9),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
        ),
      ),
      initialRoute: AppRoutes.inicio,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
