import 'package:flutter/material.dart';
import '../../tema/tema_app.dart';

/// Atomo 5: Insignia (Badge) para mostrar categorias y estados visuales
class InsigniaTipo extends StatelessWidget {
  final String texto;
  final Color? colorFondo;
  final Color? colorTexto;
  final IconData? icono;

  const InsigniaTipo({
    super.key,
    required this.texto,
    this.colorFondo,
    this.colorTexto,
    this.icono,
  });

  @override
  Widget build(BuildContext context) {
    final fondo = colorFondo ?? TemaApp.acento.withOpacity(0.15);
    final textoCol = colorTexto ?? TemaApp.secundario;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: fondo,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: textoCol.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icono != null) ...[
            Icon(icono, size: 14, color: textoCol),
            const SizedBox(width: 4),
          ],
          Text(
            texto,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textoCol,
            ),
          ),
        ],
      ),
    );
  }
}
