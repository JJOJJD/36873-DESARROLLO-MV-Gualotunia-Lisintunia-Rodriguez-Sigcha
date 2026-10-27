import 'package:flutter/material.dart';
import '../../modelo/consumo_modelo.dart';
import '../moleculas/encabezado_pantalla.dart';
import '../organismos/tarjeta_detalle_pago.dart';

/// Pantalla 3: Detalle de Pago y Liquidacion de la Planilla
class DetallePagoPantalla extends StatelessWidget {
  const DetallePagoPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final modelo = ModalRoute.of(context)!.settings.arguments as ConsumoAguaModelo;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comprobante de Pago'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 540),
              child: Column(
                children: [
                  const EncabezadoPantalla(
                    icono: Icons.receipt_long,
                    titulo: 'Planilla Liquidada',
                    subtitulo: 'Resumen financiero con cargos fijos y recargos aplicados',
                  ),
                  const SizedBox(height: 20),
                  TarjetaDetallePago(
                    modelo: modelo,
                    alVolverACalcular: () {
                      Navigator.pop(context);
                    },
                    alCerrarSesion: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
