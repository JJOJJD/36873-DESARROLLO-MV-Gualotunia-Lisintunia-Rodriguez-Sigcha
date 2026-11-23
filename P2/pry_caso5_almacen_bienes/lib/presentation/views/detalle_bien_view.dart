import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/bien.dart';
import '../../routes/app_routes.dart';
import '../viewmodels/almacen_viewmodel.dart';
import '../widgets/estado_badge.dart';

class DetalleBienView extends StatelessWidget {
  final Bien bien;

  const DetalleBienView({super.key, required this.bien});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AlmacenViewModel>();
    final bienActual = vm.bienes.firstWhere(
      (b) => b.id == bien.id,
      orElse: () => bien,
    );

    return Scaffold(
      appBar: AppBar(title: Text(bienActual.codigoInstitucional)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          bienActual.nombre,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      EstadoBadge(estado: bienActual.estado),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _InfoRow('Código institucional',
                      bienActual.codigoInstitucional),
                  _InfoRow('Categoría', bienActual.categoria),
                  _InfoRow(
                    'Disponibilidad',
                    '${bienActual.cantidadDisponible} de ${bienActual.cantidadTotal} unidades',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Acciones de Almacén',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          if (bienActual.puedeEntregarse)
            FilledButton.icon(
              icon: const Icon(Icons.assignment_add),
              label: const Text('Entregar este bien'),
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.nuevaEntrega),
            ),
          const SizedBox(height: 8),
          if (bienActual.estado != EstadoBien.dadoDeBaja) ...[
            if (bienActual.estado != EstadoBien.enMantenimiento)
              OutlinedButton.icon(
                icon: const Icon(Icons.build_outlined),
                label: const Text('Enviar a En mantenimiento'),
                onPressed: () => _cambiarEstado(
                  context,
                  bienActual.id,
                  EstadoBien.enMantenimiento,
                ),
              ),
            if (bienActual.estado == EstadoBien.enMantenimiento)
              OutlinedButton.icon(
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Habilitar como Disponible'),
                onPressed: () => _cambiarEstado(
                  context,
                  bienActual.id,
                  EstadoBien.disponible,
                ),
              ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFC5221F),
              ),
              icon: const Icon(Icons.block_outlined),
              label: const Text('Dar de baja definitiva'),
              onPressed: () => _cambiarEstado(
                context,
                bienActual.id,
                EstadoBien.dadoDeBaja,
              ),
            ),
          ] else
            const Card(
              color: Color(0xFFFCE8E6),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Este bien fue dado de baja y no puede volver a entregarse.',
                  style: TextStyle(color: Color(0xFFC5221F)),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _cambiarEstado(
    BuildContext context,
    int bienId,
    String nuevoEstado,
  ) async {
    final error = await context
        .read<AlmacenViewModel>()
        .cambiarEstadoBien(bienId, nuevoEstado);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error ?? 'Estado actualizado a $nuevoEstado'),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
