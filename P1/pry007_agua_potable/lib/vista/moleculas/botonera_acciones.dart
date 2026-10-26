import 'package:flutter/material.dart';
import '../atomos/boton_primario.dart';
import '../atomos/boton_secundario.dart';

/// Molecula 3: Conjunto de acciones principales y secundarias
class BotoneraAcciones extends StatelessWidget {
  final String textoPrincipal;
  final VoidCallback alPresionarPrincipal;
  final IconData? iconoPrincipal;
  final String textoSecundario;
  final VoidCallback alPresionarSecundario;
  final IconData? iconoSecundario;

  const BotoneraAcciones({
    super.key,
    required this.textoPrincipal,
    required this.alPresionarPrincipal,
    this.iconoPrincipal,
    required this.textoSecundario,
    required this.alPresionarSecundario,
    this.iconoSecundario,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: BotonPrimario(
            texto: textoPrincipal,
            alPresionar: alPresionarPrincipal,
            icono: iconoPrincipal,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: BotonSecundario(
            texto: textoSecundario,
            alPresionar: alPresionarSecundario,
            icono: iconoSecundario,
          ),
        ),
      ],
    );
  }
}
