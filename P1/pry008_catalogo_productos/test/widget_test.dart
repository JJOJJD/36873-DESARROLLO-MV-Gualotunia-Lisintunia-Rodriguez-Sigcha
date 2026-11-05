import 'package:flutter_test/flutter_test.dart';
import 'package:pry08_catalogo_productos/view_model/catalogo_viewmodel.dart';

void main() {
  group('CatalogoViewModel - Pruebas Unitarias', () {
    late CatalogoViewModel viewModel;

    setUp(() {
      viewModel = CatalogoViewModel();
    });

    test('Inicialmente la lista de productos no está vacía y favoritos está vacío', () {
      expect(viewModel.productos.isNotEmpty, true);
      expect(viewModel.favoritosIds.isEmpty, true);
      expect(viewModel.productoSeleccionado, isNull);
      expect(viewModel.indiceImagenActual, 0);
    });

    test('Alternar favorito agrega y retira el id correctamente', () {
      final idProducto = viewModel.productos.first.id;

      // 1. Agregar a favoritos
      viewModel.alternarFavorito(idProducto);
      expect(viewModel.esFavorito(idProducto), true);
      expect(viewModel.favoritosIds.contains(idProducto), true);

      // 2. Quitar de favoritos
      viewModel.alternarFavorito(idProducto);
      expect(viewModel.esFavorito(idProducto), false);
      expect(viewModel.favoritosIds.contains(idProducto), false);
    });

    test('Selección de producto reinicia índice de imagen a 0', () {
      final producto = viewModel.productos[1];
      viewModel.cambiarImagen(1);
      expect(viewModel.indiceImagenActual, 0); // No cambia si productoSeleccionado es null

      viewModel.seleccionarProducto(producto);
      expect(viewModel.productoSeleccionado, producto);
      expect(viewModel.indiceImagenActual, 0);
    });

    test('Navegación horizontal de imágenes (siguiente / anterior)', () {
      final producto = viewModel.productos.first;
      viewModel.seleccionarProducto(producto);

      // Siguiente imagen
      viewModel.siguienteImagen();
      expect(viewModel.indiceImagenActual, 1);

      // No excede el límite
      viewModel.siguienteImagen();
      expect(viewModel.indiceImagenActual, 1);

      // Anterior imagen
      viewModel.anteriorImagen();
      expect(viewModel.indiceImagenActual, 0);

      // No desciende de 0
      viewModel.anteriorImagen();
      expect(viewModel.indiceImagenActual, 0);
    });
  });
}
