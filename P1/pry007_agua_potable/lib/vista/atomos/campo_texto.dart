import 'package:flutter/material.dart';

/// Atomo 1: Campo de texto reutilizable
class CampoTexto extends StatelessWidget {
  final TextEditingController controller;
  final String etiqueta;
  final String? pista;
  final IconData? icono;
  final Widget? iconoFinal;
  final bool ocultarTexto;
  final TextInputType tipoTeclado;
  final String? Function(String?)? validador;

  const CampoTexto({
    super.key,
    required this.controller,
    required this.etiqueta,
    this.pista,
    this.icono,
    this.iconoFinal,
    this.ocultarTexto = false,
    this.tipoTeclado = TextInputType.text,
    this.validador,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: ocultarTexto,
      keyboardType: tipoTeclado,
      validator: validador,
      decoration: InputDecoration(
        labelText: etiqueta,
        hintText: pista,
        prefixIcon: icono != null ? Icon(icono) : null,
        suffixIcon: iconoFinal,
      ),
    );
  }
}
