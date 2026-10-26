import 'package:flutter/material.dart';

/// Atomo 2: Etiqueta de texto reutilizable con estilos tipograficos consistentes
class EtiquetaTexto extends StatelessWidget {
  final String texto;
  final double tamano;
  final FontWeight peso;
  final Color? color;
  final TextAlign alineacion;
  final int? maxLineas;

  const EtiquetaTexto({
    super.key,
    required this.texto,
    this.tamano = 14.0,
    this.peso = FontWeight.normal,
    this.color,
    this.alineacion = TextAlign.start,
    this.maxLineas,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      textAlign: alineacion,
      maxLines: maxLineas,
      overflow: maxLineas != null ? TextOverflow.ellipsis : null,
      style: TextStyle(
        fontSize: tamano,
        fontWeight: peso,
        color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
      ),
    );
  }
}
