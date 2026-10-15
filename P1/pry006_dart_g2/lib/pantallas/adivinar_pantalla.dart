import 'package:flutter/material.dart';

class AdivinarPantalla extends StatelessWidget {
  const AdivinarPantalla({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('9. Adivina el número')),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.pending_actions, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Ejercicio 9: Adivina el número\n(Pendiente de implementación por el equipo)',
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
