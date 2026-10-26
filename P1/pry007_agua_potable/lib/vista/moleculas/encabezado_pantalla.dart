import 'package:flutter/material.dart';
import '../../tema/tema_app.dart';
import '../atomos/etiqueta_texto.dart';

/// Molecula 5: Encabezado contextual con icono, titulo y subtitulo
class EncabezadoPantalla extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String subtitulo;

  const EncabezadoPantalla({
    super.key,
    required this.icono,
    required this.titulo,
    required this.subtitulo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            color: TemaApp.primario.withOpacity(0.12),
            shape: BoxShape.circle,
            border: Border.all(color: TemaApp.primario.withOpacity(0.3), width: 2),
          ),
          child: Icon(
            icono,
            size: 34,
            color: TemaApp.primario,
          ),
        ),
        const SizedBox(height: 14),
        EtiquetaTexto(
          texto: titulo,
          tamano: 22,
          peso: FontWeight.bold,
          color: TemaApp.textoPrincipal,
          alineacion: TextAlign.center,
        ),
        const SizedBox(height: 6),
        EtiquetaTexto(
          texto: subtitulo,
          tamano: 14,
          color: TemaApp.textoSecundario,
          alineacion: TextAlign.center,
        ),
      ],
    );
  }
}
