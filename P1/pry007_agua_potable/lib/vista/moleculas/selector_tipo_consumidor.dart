import 'package:flutter/material.dart';
import '../../tema/tema_app.dart';
import '../atomos/etiqueta_texto.dart';

/// Molecula 2: Selector interactivo para el tipo de consumidor (Residencial / Comercial)
class SelectorTipoConsumidor extends StatelessWidget {
  final String valorSeleccionado;
  final ValueChanged<String> alCambiar;

  const SelectorTipoConsumidor({
    super.key,
    required this.valorSeleccionado,
    required this.alCambiar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EtiquetaTexto(
          texto: 'Tipo de Consumidor',
          peso: FontWeight.w600,
          tamano: 14,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildBotonOpcion(
                context,
                titulo: 'Residencial',
                icono: Icons.home_outlined,
                esActivo: valorSeleccionado == 'Residencial',
                onTap: () => alCambiar('Residencial'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildBotonOpcion(
                context,
                titulo: 'Comercial',
                icono: Icons.storefront_outlined,
                esActivo: valorSeleccionado == 'Comercial',
                onTap: () => alCambiar('Comercial'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBotonOpcion(
    BuildContext context, {
    required String titulo,
    required IconData icono,
    required bool esActivo,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: esActivo ? TemaApp.primario.withOpacity(0.12) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: esActivo ? TemaApp.primario : const Color(0xFFCBD5E1),
            width: esActivo ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icono,
              size: 20,
              color: esActivo ? TemaApp.primario : TemaApp.textoSecundario,
            ),
            const SizedBox(width: 8),
            Text(
              titulo,
              style: TextStyle(
                fontSize: 14,
                fontWeight: esActivo ? FontWeight.bold : FontWeight.w500,
                color: esActivo ? TemaApp.primario : TemaApp.textoPrincipal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
