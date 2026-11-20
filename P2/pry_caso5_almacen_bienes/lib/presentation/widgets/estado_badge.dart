import 'package:flutter/material.dart';
import '../../domain/entities/bien.dart';

class EstadoBadge extends StatelessWidget {
  final String estado;

  const EstadoBadge({super.key, required this.estado});

  @override
  Widget build(BuildContext context) {
    final (Color bg, Color fg, IconData icon) = switch (estado) {
      EstadoBien.disponible => (
          const Color(0xFFE6F4EA),
          const Color(0xFF137333),
          Icons.check_circle_outline,
        ),
      EstadoBien.entregado => (
          const Color(0xFFE8F0FE),
          const Color(0xFF1967D2),
          Icons.assignment_turned_in_outlined,
        ),
      EstadoBien.enMantenimiento => (
          const Color(0xFFFEF7E0),
          const Color(0xFFB06000),
          Icons.build_outlined,
        ),
      EstadoBien.dadoDeBaja => (
          const Color(0xFFFCE8E6),
          const Color(0xFFC5221F),
          Icons.block_outlined,
        ),
      _ => (
          const Color(0xFFF1F3F4),
          const Color(0xFF5F6368),
          Icons.info_outline,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 4),
          Text(
            estado,
            style: TextStyle(
              color: fg,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
