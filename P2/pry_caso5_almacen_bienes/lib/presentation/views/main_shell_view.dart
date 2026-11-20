import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../routes/app_routes.dart';
import '../viewmodels/almacen_viewmodel.dart';
import 'bienes_view.dart';
import 'entregas_view.dart';
import 'inicio_view.dart';
import 'responsables_view.dart';

class MainShellView extends StatefulWidget {
  const MainShellView({super.key});

  @override
  State<MainShellView> createState() => _MainShellViewState();
}

class _MainShellViewState extends State<MainShellView> {
  int _indice = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<AlmacenViewModel>().cargarDatosIniciales();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AlmacenViewModel>();

    final pantallas = [
      InicioView(onNavegarTab: (i) => setState(() => _indice = i)),
      const BienesView(),
      const ResponsablesView(),
      const EntregasView(),
    ];

    const titulos = [
      'Guarda de Almacén',
      'Inventario de Bienes',
      'Responsables',
      'Control de Entregas',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titulos[_indice]),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Chip(
              avatar: Icon(
                vm.apiEnLinea ? Icons.cloud_done : Icons.cloud_off,
                size: 16,
                color: vm.apiEnLinea
                    ? const Color(0xFF137333)
                    : const Color(0xFFB06000),
              ),
              label: Text(
                vm.apiEnLinea ? 'API REST' : 'Modo Local',
                style: const TextStyle(fontSize: 11),
              ),
              visualDensity: VisualDensity.compact,
            ),
          ),
          IconButton(
            tooltip: 'Recargar datos',
            icon: const Icon(Icons.refresh),
            onPressed: vm.cargando ? null : () => vm.cargarDatosIniciales(),
          ),
        ],
      ),
      body: vm.cargando && vm.bienes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : pantallas[_indice],
      floatingActionButton: _indice == 3 || _indice == 0
          ? FloatingActionButton.extended(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.nuevaEntrega),
              icon: const Icon(Icons.add_box_outlined),
              label: const Text('Nueva Entrega'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indice,
        onDestinationSelected: (i) => setState(() => _indice = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: 'Bienes',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Responsables',
          ),
          NavigationDestination(
            icon: Icon(Icons.swap_horiz_outlined),
            selectedIcon: Icon(Icons.swap_horiz),
            label: 'Entregas',
          ),
        ],
      ),
    );
  }
}
