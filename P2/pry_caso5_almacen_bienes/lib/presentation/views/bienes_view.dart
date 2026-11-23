import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/bien.dart';
import '../../routes/app_routes.dart';
import '../viewmodels/almacen_viewmodel.dart';
import '../widgets/estado_badge.dart';

class BienesView extends StatelessWidget {
  const BienesView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AlmacenViewModel>();
    final filtros = ['Todos', ...EstadoBien.valores];

    return Column(
      children: [
        SizedBox(
          height: 52,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            itemCount: filtros.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final f = filtros[i];
              final selected = vm.filtroEstado == f;
              return FilterChip(
                label: Text(f),
                selected: selected,
                onSelected: (_) => vm.cambiarFiltroEstado(f),
              );
            },
          ),
        ),
        Expanded(
          child: vm.bienesFiltrados.isEmpty
              ? const Center(
                  child: Text('No hay bienes en este estado.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(14, 4, 14, 80),
                  itemCount: vm.bienesFiltrados.length,
                  itemBuilder: (_, i) {
                    final bien = vm.bienesFiltrados[i];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                bien.nombre,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            EstadoBadge(estado: bien.estado),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Código: ${bien.codigoInstitucional} • ${bien.categoria}',
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Stock disponible: ${bien.cantidadDisponible} de ${bien.cantidadTotal}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.detalleBien,
                          arguments: bien,
                        ),
                      ),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Registrar Nuevo Bien'),
              onPressed: () => _mostrarDialogoNuevoBien(context),
            ),
          ),
        ),
      ],
    );
  }

  void _mostrarDialogoNuevoBien(BuildContext context) {
    final codigoCtrl = TextEditingController();
    final nombreCtrl = TextEditingController();
    final categoriaCtrl = TextEditingController();
    final cantidadCtrl = TextEditingController(text: '1');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nuevo Bien Institucional'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: codigoCtrl,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  labelText: 'Código institucional único',
                  hintText: 'Ej. ESPE-ALM-006',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nombreCtrl,
                decoration: const InputDecoration(labelText: 'Nombre del bien'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: categoriaCtrl,
                decoration: const InputDecoration(labelText: 'Categoría'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: cantidadCtrl,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Cantidad disponible'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              final cant = int.tryParse(cantidadCtrl.text) ?? 0;
              final error = await context.read<AlmacenViewModel>().agregarBien(
                    codigoInstitucional: codigoCtrl.text,
                    nombre: nombreCtrl.text,
                    categoria: categoriaCtrl.text,
                    cantidad: cant,
                  );
              if (!ctx.mounted) return;
              if (error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error)),
                );
              } else {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Bien registrado correctamente')),
                );
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
