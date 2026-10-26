import 'package:flutter/material.dart';
import '../atomos/campo_texto.dart';
import '../atomos/etiqueta_texto.dart';

/// Molecula 1: Campo de formulario con etiqueta descriptiva y campo de texto
class CampoFormulario extends StatelessWidget {
  final String etiqueta;
  final TextEditingController controller;
  final String? pista;
  final IconData? icono;
  final Widget? iconoFinal;
  final bool ocultarTexto;
  final TextInputType tipoTeclado;
  final String? Function(String?)? validador;

  const CampoFormulario({
    super.key,
    required this.etiqueta,
    required this.controller,
    this.pista,
    this.icono,
    this.iconoFinal,
    this.ocultarTexto = false,
    this.tipoTeclado = TextInputType.text,
    this.validador,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EtiquetaTexto(
          texto: etiqueta,
          peso: FontWeight.w600,
          tamano: 14,
        ),
        const SizedBox(height: 6),
        CampoTexto(
          controller: controller,
          etiqueta: etiqueta,
          pista: pista,
          icono: icono,
          iconoFinal: iconoFinal,
          ocultarTexto: ocultarTexto,
          tipoTeclado: tipoTeclado,
          validador: validador,
        ),
      ],
    );
  }
}
