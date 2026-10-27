import 'package:flutter/material.dart';
import '../../modelo/consumo_modelo.dart';
import '../../tema/tema_app.dart';
import '../atomos/etiqueta_texto.dart';
import '../atomos/insignia_tipo.dart';
import '../atomos/boton_primario.dart';
import '../atomos/boton_secundario.dart';
import '../moleculas/fila_detalle.dart';

/// Organismo 3: Tarjeta detallada de liquidacion y factura de consumo de agua
class TarjetaDetallePago extends StatelessWidget {
  final ConsumoAguaModelo modelo;
  final VoidCallback alVolverACalcular;
  final VoidCallback alCerrarSesion;

  const TarjetaDetallePago({
    super.key,
    required this.modelo,
    required this.alVolverACalcular,
    required this.alCerrarSesion,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Cabecera con numero de cuenta y tipo de consumidor
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EtiquetaTexto(
                      texto: 'Planilla de Servicio de Agua',
                      tamano: 12,
                      color: TemaApp.textoSecundario,
                      peso: FontWeight.bold,
                    ),
                    const SizedBox(height: 2),
                    EtiquetaTexto(
                      texto: 'Cuenta: ${modelo.numeroCuenta}',
                      tamano: 18,
                      peso: FontWeight.bold,
                      color: TemaApp.textoPrincipal,
                    ),
                  ],
                ),
                InsigniaTipo(
                  texto: modelo.tipoConsumidor,
                  icono: modelo.tipoConsumidor == 'Residencial'
                      ? Icons.home
                      : Icons.storefront,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: TemaApp.fondo,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.person, size: 18, color: TemaApp.primario),
                  const SizedBox(width: 8),
                  Expanded(
                    child: EtiquetaTexto(
                      texto: 'Cliente: ${modelo.nombreCliente}',
                      tamano: 14,
                      peso: FontWeight.w600,
                      color: TemaApp.textoPrincipal,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Divider(),
            const SizedBox(height: 8),

            // Medicion volumetrica
            const EtiquetaTexto(
              texto: 'Medición de Consumo',
              tamano: 14,
              peso: FontWeight.bold,
              color: TemaApp.secundario,
            ),
            const SizedBox(height: 6),
            FilaDetalle(
              etiqueta: 'Lectura Anterior:',
              valor: '${modelo.lecturaAnterior.toStringAsFixed(2)} m³',
              icono: Icons.history,
            ),
            FilaDetalle(
              etiqueta: 'Lectura Actual:',
              valor: '${modelo.lecturaActual.toStringAsFixed(2)} m³',
              icono: Icons.speed,
            ),
            FilaDetalle(
              etiqueta: 'Consumo Efectivo:',
              valor: '${modelo.consumoM3.toStringAsFixed(2)} m³',
              icono: Icons.water_drop,
              esDestacado: true,
            ),
            FilaDetalle(
              etiqueta: 'Rango y Tarifa Aplicada:',
              valor: '\$${modelo.tarifaPorM3.toStringAsFixed(2)} / m³ (${modelo.rangoConsumo})',
              icono: Icons.price_change_outlined,
            ),

            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),

            // Liquidacion financiera
            const EtiquetaTexto(
              texto: 'Detalle de Rubros',
              tamano: 14,
              peso: FontWeight.bold,
              color: TemaApp.secundario,
            ),
            const SizedBox(height: 6),
            FilaDetalle(
              etiqueta: 'Valor Consumo (${modelo.consumoM3.toStringAsFixed(2)} × \$${modelo.tarifaPorM3.toStringAsFixed(2)}):',
              valor: '\$ ${modelo.valorConsumo.toStringAsFixed(2)}',
              icono: Icons.receipt_long_outlined,
            ),
            FilaDetalle(
              etiqueta: 'Cargo Fijo de Servicio:',
              valor: '\$ ${modelo.cargoFijo.toStringAsFixed(2)}',
              icono: Icons.home_repair_service_outlined,
            ),
            FilaDetalle(
              etiqueta: 'Subtotal del Servicio:',
              valor: '\$ ${modelo.subtotal.toStringAsFixed(2)}',
              icono: Icons.functions,
            ),
            FilaDetalle(
              etiqueta: 'Recargo Tratamiento / Saneamiento (10%):',
              valor: '\$ ${modelo.recargo.toStringAsFixed(2)}',
              icono: Icons.add_circle_outline,
            ),

            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: TemaApp.primario.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: TemaApp.primario.withOpacity(0.4)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const EtiquetaTexto(
                    texto: 'TOTAL A PAGAR:',
                    tamano: 16,
                    peso: FontWeight.bold,
                    color: TemaApp.textoPrincipal,
                  ),
                  EtiquetaTexto(
                    texto: '\$ ${modelo.totalPagar.toStringAsFixed(2)}',
                    tamano: 22,
                    peso: FontWeight.bold,
                    color: TemaApp.primario,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: BotonPrimario(
                    texto: 'Nueva Consulta',
                    alPresionar: alVolverACalcular,
                    icono: Icons.replay,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: BotonSecundario(
                    texto: 'Salir',
                    alPresionar: alCerrarSesion,
                    icono: Icons.logout,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
