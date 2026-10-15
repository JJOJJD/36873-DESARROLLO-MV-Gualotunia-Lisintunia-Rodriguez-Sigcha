import 'package:flutter/material.dart';

class MenuPantalla extends StatelessWidget {
  const MenuPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    const opciones = {
      '/vehiculos': '6. Impuesto de vehículos',
      '/banco': '7. Banco Bandido de peluche',
      '/ahorro': '8. Ahorro anual',
      '/adivinar': '9. Adivina el número',
      '/intervalo': '10. Intervalo de números',
    };
    return Scaffold(
      appBar: AppBar(title: const Text('Menú de ejercicios')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('NRC 36873', style: TextStyle(fontSize: 22)),
          const Text('Selecciona un ejercicio.'),
          const SizedBox(height: 20),
          for (final opcion in opciones.entries)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, opcion.key),
                child: Text(opcion.value),
              ),
            ),
        ],
      ),
    );
  }
}
