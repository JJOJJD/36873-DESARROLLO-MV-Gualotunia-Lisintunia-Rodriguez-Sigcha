import 'package:flutter/material.dart';
import '../logica/ejercicios_logica.dart';
import 'formulario_ejercicio.dart';

class BancoPantalla extends StatelessWidget {
  const BancoPantalla({super.key});

  @override
  Widget build(BuildContext context) => FormularioEjercicio(
    titulo: '7. Banco Bandido de peluche',
    instrucciones:
        'Una línea por cliente: saldo anterior; compras; pago del corte anterior. Moroso: pago menor al 15% del saldo; paga 12% de interés y \$200 de multa.',
    etiquetas: const ['Clientes (saldo; compras; pago)'],
    multilinea: true,
    calcular: (datos) => EjerciciosLogica().banco(datos[0]),
  );
}
