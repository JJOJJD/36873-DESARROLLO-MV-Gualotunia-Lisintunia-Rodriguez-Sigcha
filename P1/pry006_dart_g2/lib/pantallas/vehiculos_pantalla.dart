import 'package:flutter/material.dart';
import '../logica/ejercicios_logica.dart';
import 'formulario_ejercicio.dart';

class VehiculosPantalla extends StatelessWidget {
  const VehiculosPantalla({super.key});

  @override
  Widget build(BuildContext context) => FormularioEjercicio(
    titulo: '6. Impuesto de vehículos',
    instrucciones:
        'Una línea por vehículo: clave (1 = 10%, 2 = 7%, 3 = 5%); valor. Ejemplo: 1; 250000',
    etiquetas: ['Vehículos (clave; valor)'],
    multilinea: true,
    calcular: (datos) => EjerciciosLogica().vehiculos(datos[0]),
  );
}
