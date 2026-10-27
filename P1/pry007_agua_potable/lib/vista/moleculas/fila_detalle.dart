import 'package:flutter/material.dart';
import '../../tema/tema_app.dart';
import '../atomos/etiqueta_texto.dart';

/// Molecula 4: Fila descriptiva para mostrar rubros y valores calculados
class FilaDetalle extends StatelessWidget {
  final String etiqueta;
  final String valor;
  final IconData? icono;
  final bool esDestacado;
  final Color? colorValor;

  const FilaDetalle({
    super.key,
    required this.etiqueta,
    required this.valor,
    this.icono,
    this.esDestacado = false,
    this.colorValor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icono != null) ...[
            Icon(
              icono,
              size: esDestacado ? 20 : 18,
              color: esDestacado ? TemaApp.primario : TemaApp.textoSecundario,
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: EtiquetaTexto(
              texto: etiqueta,
              tamano: esDestacado ? 15 : 14,
              peso: esDestacado ? FontWeight.bold : FontWeight.w500,
              color: esDestacado ? TemaApp.textoPrincipal : TemaApp.textoSecundario,
            ),
          ),
          EtiquetaTexto(
            texto: valor,
            tamano: esDestacado ? 17 : 14,
            peso: esDestacado ? FontWeight.bold : FontWeight.w600,
            color: colorValor ?? (esDestacado ? TemaApp.primario : TemaApp.textoPrincipal),
          ),
        ],
      ),
    );
  }
}
