import 'package:flutter/material.dart';
import '../../tema/tema_app.dart';
import '../moleculas/encabezado_pantalla.dart';
import '../atomos/etiqueta_texto.dart';
import '../atomos/boton_secundario.dart';

/// Pantalla 2 (Inicial): Pantalla base del modulo de consumo para integracion del equipo
class ConsumoPantalla extends StatelessWidget {
  const ConsumoPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Consumo'),
        actions: [
          IconButton(
            tooltip: 'Cerrar Sesión',
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const EncabezadoPantalla(
                        icono: Icons.speed,
                        titulo: 'Módulo de Consumo',
                        subtitulo: 'Portal de registro de lecturas y liquidación',
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: TemaApp.fondo,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFBAE6FD)),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EtiquetaTexto(
                              texto: 'Acceso exitoso al sistema.',
                              peso: FontWeight.bold,
                              tamano: 15,
                              color: TemaApp.secundario,
                            ),
                            SizedBox(height: 8),
                            EtiquetaTexto(
                              texto: 'La arquitectura base, diseño atómico y módulo de login han sido inicializados por David Rodríguez. Los submódulos de modelo, reglas de negocio y facturación se integrarán por los demás miembros del equipo.',
                              tamano: 13,
                              color: TemaApp.textoSecundario,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      BotonSecundario(
                        texto: 'Cerrar Sesión',
                        alPresionar: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        icono: Icons.arrow_back,
                        expandir: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
