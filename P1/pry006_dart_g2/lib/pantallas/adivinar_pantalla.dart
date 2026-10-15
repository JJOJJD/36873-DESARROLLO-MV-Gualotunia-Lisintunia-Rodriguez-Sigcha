import 'package:flutter/material.dart';
import '../logica/ejercicios_logica.dart';

class AdivinarPantalla extends StatefulWidget {
  const AdivinarPantalla({super.key});

  @override
  State<AdivinarPantalla> createState() => _AdivinarPantallaState();
}

class _AdivinarPantallaState extends State<AdivinarPantalla> {
  final control = TextEditingController();
  var juego = JuegoAdivinar();
  String resultado = 'Adivina el número del 1 al 100. Tienes 10 intentos.';

  void probar() {
    FocusScope.of(context).unfocus();
    try {
      final respuesta = juego.probar(control.text);
      setState(() => resultado = respuesta);
      control.clear();
    } on FormatException catch (error) {
      setState(() => resultado = error.message);
    }
  }

  void reiniciar() {
    control.clear();
    setState(() {
      juego = JuegoAdivinar();
      resultado = 'Nuevo juego. Tienes 10 intentos.';
    });
  }

  @override
  void dispose() {
    control.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('9. Adivina el número')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Intentos restantes: ${juego.restantes}'),
          const SizedBox(height: 16),
          TextField(
            controller: control,
            keyboardType: TextInputType.number,
            enabled: !juego.terminado,
            onSubmitted: (_) => probar(),
            decoration: const InputDecoration(
              labelText: 'Tu número',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 14),
          ElevatedButton(
            onPressed: juego.terminado ? null : probar,
            child: const Text('Probar'),
          ),
          TextButton(onPressed: reiniciar, child: const Text('Reiniciar')),
          const SizedBox(height: 10),
          Text(resultado, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Volver al menú'),
          ),
        ],
      ),
    ),
  );
}
