import 'package:flutter/material.dart';
import '../logica/ejercicios_logica.dart';
import 'formulario_ejercicio.dart';

class IntervaloPantalla extends StatelessWidget {
  const IntervaloPantalla({super.key});

  @override
  Widget build(BuildContext context) => FormularioEjercicio(
    titulo: '10. Intervalo de números',
    instrucciones:
        'Ingresa los límites (el inferior no puede ser mayor que el superior) y luego los números, uno por línea. Se detiene al llegar al 0.',
    etiquetas: ['Límite inferior', 'Límite superior', 'Números (termina con 0)'],
    multilinea: true,
    calcular: (datos) => EjerciciosLogica().intervalo(datos),
  );
}
