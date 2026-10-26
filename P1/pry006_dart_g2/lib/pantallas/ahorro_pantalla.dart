import 'package:flutter/material.dart';
import '../logica/ejercicios_logica.dart';
import 'formulario_ejercicio.dart';

class AhorroPantalla extends StatelessWidget {
  const AhorroPantalla({super.key});

  @override
  Widget build(BuildContext context) => FormularioEjercicio(
    titulo: '8. Ahorro anual',
    instrucciones:
        'Ingresa el depósito de cada mes, uno por línea (12 líneas).',
    etiquetas: ['Depósitos mensuales'],
    multilinea: true,
    calcular: (datos) => EjerciciosLogica().ahorro(datos[0]),
  );
}
