import 'package:flutter/material.dart';

class AhorroPantalla extends StatelessWidget {
  const AhorroPantalla({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('8. Ahorro anual')),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.pending_actions, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Ejercicio 8: Ahorro anual\n(Pendiente de implementación por el equipo)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Volver al menú'),
            ),
          ],
        ),
      ),
    ),
  );
}
