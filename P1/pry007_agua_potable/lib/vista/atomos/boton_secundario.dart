import 'package:flutter/material.dart';

/// Atomo 4: Boton secundario con borde para acciones alternativas (limpiar, volver)
class BotonSecundario extends StatelessWidget {
  final String texto;
  final VoidCallback alPresionar;
  final IconData? icono;
  final bool expandir;

  const BotonSecundario({
    super.key,
    required this.texto,
    required this.alPresionar,
    this.icono,
    this.expandir = false,
  });

  @override
  Widget build(BuildContext context) {
    final Widget contenido = OutlinedButton(
      onPressed: alPresionar,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icono != null) ...[
            Icon(icono, size: 18),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Text(
              texto,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );

    if (expandir) {
      return SizedBox(
        width: double.infinity,
        child: contenido,
      );
    }

    return contenido;
  }
}
