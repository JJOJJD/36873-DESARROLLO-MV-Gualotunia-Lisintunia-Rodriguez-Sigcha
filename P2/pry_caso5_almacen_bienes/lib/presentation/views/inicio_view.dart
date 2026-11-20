import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/bien.dart';
import '../../routes/app_routes.dart';
import '../viewmodels/almacen_viewmodel.dart';

class InicioView extends StatelessWidget {
  final ValueChanged<int> onNavegarTab;

  const InicioView({super.key, required this.onNavegarTab});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AlmacenViewModel>();
    final colorScheme = Theme.of(context).colorScheme;

    return RefreshIndicator(
      onRefresh: () => vm.cargarDatosIniciales(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Control de Bienes Institucionales',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Caso 5 • Gestión de entregas temporales o definitivas desde almacén.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.88),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: colorScheme.primary,
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.nuevaEntrega),
                      icon: const Icon(Icons.assignment_add, size: 18),
                      label: const Text('Registrar Entrega'),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white54),
                      ),
                      onPressed: () => onNavegarTab(1),
                      child: const Text('Ver Bienes'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Resumen de Inventario',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.55,
            children: [
              _MetricCard(
                titulo: 'Disponibles',
                valor: vm.contarPorEstado(EstadoBien.disponible).toString(),
                icono: Icons.check_circle_outline,
                color: const Color(0xFF137333),
                onTap: () {
                  vm.cambiarFiltroEstado(EstadoBien.disponible);
                  onNavegarTab(1);
                },
              ),
              _MetricCard(
                titulo: 'Entregados',
                valor: vm.contarPorEstado(EstadoBien.entregado).toString(),
                icono: Icons.assignment_turned_in_outlined,
                color: const Color(0xFF1967D2),
                onTap: () {
                  vm.cambiarFiltroEstado(EstadoBien.entregado);
                  onNavegarTab(1);
                },
              ),
              _MetricCard(
                titulo: 'En mantenimiento',
                valor:
                    vm.contarPorEstado(EstadoBien.enMantenimiento).toString(),
                icono: Icons.build_outlined,
                color: const Color(0xFFB06000),
                onTap: () {
                  vm.cambiarFiltroEstado(EstadoBien.enMantenimiento);
                  onNavegarTab(1);
                },
              ),
              _MetricCard(
                titulo: 'Dados de baja',
                valor: vm.contarPorEstado(EstadoBien.dadoDeBaja).toString(),
                icono: Icons.block_outlined,
                color: const Color(0xFFC5221F),
                onTap: () {
                  vm.cambiarFiltroEstado(EstadoBien.dadoDeBaja);
                  onNavegarTab(1);
                },
              ),
            ],
          ),
          const SizedBox(height: 18),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: colorScheme.primaryContainer,
                child: Icon(Icons.swap_horiz, color: colorScheme.primary),
              ),
              title: const Text('Entregas activas en curso'),
              subtitle: Text(
                '${vm.entregasActivas} entregas pendientes de devolución • ${vm.responsables.length} responsables registrados',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => onNavegarTab(3),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String titulo;
  final String valor;
  final IconData icono;
  final Color color;
  final VoidCallback onTap;

  const _MetricCard({
    required this.titulo,
    required this.valor,
    required this.icono,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icono, color: color, size: 22),
                  Text(
                    valor,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
