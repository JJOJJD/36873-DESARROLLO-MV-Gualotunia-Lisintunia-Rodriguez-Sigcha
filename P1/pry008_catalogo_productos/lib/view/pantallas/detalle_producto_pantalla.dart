import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/producto_model.dart';
import '../../view_model/catalogo_viewmodel.dart';

class DetalleProductoPantalla extends StatelessWidget {
  const DetalleProductoPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final producto = ModalRoute.of(context)!.settings.arguments as ProductoModelo;
    final viewModel = context.watch<CatalogoViewModel>();
    final esFav = viewModel.esFavorito(producto.id);
    final indiceImg = viewModel.indiceImagenActual;

    return Scaffold(
      appBar: AppBar(
        title: Text(producto.nombre),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              esFav ? Icons.favorite : Icons.favorite_border,
              color: esFav ? Colors.red.shade200 : Colors.white,
            ),
            onPressed: () {
              context.read<CatalogoViewModel>().alternarFavorito(producto.id);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Gesto 2: Deslizamiento horizontal sobre la imagen
              GestureDetector(
                onHorizontalDragEnd: (detalles) {
                  if (detalles.primaryVelocity != null) {
                    if (detalles.primaryVelocity! < 0) {
                      // Deslizar izquierda -> siguiente imagen
                      context.read<CatalogoViewModel>().siguienteImagen();
                    } else if (detalles.primaryVelocity! > 0) {
                      // Deslizar derecha -> imagen anterior
                      context.read<CatalogoViewModel>().anteriorImagen();
                    }
                  }
                },
                child: Card(
                  elevation: 3,
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    height: 220,
                    color: Colors.grey.shade100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _obtenerIconoPorIndice(producto.categoria, indiceImg),
                          size: 90,
                          color: Colors.blue.shade600,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Vista ${indiceImg + 1} de ${producto.imagenes.length}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.chevron_left, color: Colors.grey.shade400),
                            const Text(
                              'Desliza horizontalmente',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            Icon(Icons.chevron_right, color: Colors.grey.shade400),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Indicador de imagen actual
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  producto.imagenes.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: index == indiceImg ? 18 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: index == indiceImg ? Colors.blue.shade700 : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Datos del producto
              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              producto.nombre,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '\$${producto.precio.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Chip(
                        label: Text(producto.categoria),
                        backgroundColor: Colors.blue.shade50,
                      ),
                      const Divider(height: 24),
                      const Text(
                        'Descripción',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        producto.descripcion,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          esFav ? Icons.favorite : Icons.favorite_border,
                          color: esFav ? Colors.red : Colors.grey,
                        ),
                        title: Text(
                          esFav ? 'Producto en Favoritos' : 'No marcado en favoritos',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: esFav ? Colors.red.shade700 : Colors.grey.shade600,
                          ),
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            context.read<CatalogoViewModel>().alternarFavorito(producto.id);
                          },
                          child: Text(esFav ? 'Quitar' : 'Marcar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Volver al Catálogo'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _obtenerIconoPorIndice(String categoria, int indice) {
    if (categoria == 'Laptops') {
      return indice == 0 ? Icons.laptop_mac : Icons.keyboard;
    } else if (categoria == 'Audio') {
      return indice == 0 ? Icons.headphones : Icons.speaker;
    } else if (categoria == 'Accesorios') {
      return indice == 0 ? Icons.watch : Icons.battery_charging_full;
    }
    return Icons.shopping_bag;
  }
}
