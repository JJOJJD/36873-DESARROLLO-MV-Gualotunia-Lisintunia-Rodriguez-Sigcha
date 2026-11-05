import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/catalogo_viewmodel.dart';

class ProductosPantalla extends StatelessWidget {
  const ProductosPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CatalogoViewModel>();
    final listaProductos = viewModel.productos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Productos'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.favorite, color: Colors.white),
                const SizedBox(width: 4),
                Text(
                  '${viewModel.favoritosIds.length}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.blue.shade50,
            child: const Row(
              children: [
                Icon(Icons.touch_app, color: Colors.blue),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Doble toque sobre un producto para agregar o quitar de favoritos.',
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: listaProductos.length,
              itemBuilder: (context, index) {
                final producto = listaProductos[index];
                final esFav = viewModel.esFavorito(producto.id);

                return GestureDetector(
                  onTap: () {
                    context.read<CatalogoViewModel>().seleccionarProducto(producto);
                    Navigator.pushNamed(context, '/detalle', arguments: producto);
                  },
                  onDoubleTap: () {
                    context.read<CatalogoViewModel>().alternarFavorito(producto.id);
                  },
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              _obtenerIcono(producto.categoria),
                              color: Colors.blue.shade800,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  producto.nombre,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Categoría: ${producto.categoria}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '\$${producto.precio.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              esFav ? Icons.favorite : Icons.favorite_border,
                              color: esFav ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              context.read<CatalogoViewModel>().alternarFavorito(producto.id);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _obtenerIcono(String categoria) {
    switch (categoria) {
      case 'Laptops':
        return Icons.laptop_mac;
      case 'Audio':
        return Icons.headphones;
      case 'Accesorios':
        return Icons.devices_other;
      default:
        return Icons.shopping_bag;
    }
  }
}
