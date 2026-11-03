class ProductoModelo {
  final int id;
  final String nombre;
  final double precio;
  final String descripcion;
  final List<String> imagenes;
  final String categoria;

  ProductoModelo({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.descripcion,
    required this.imagenes,
    required this.categoria,
  });
}

