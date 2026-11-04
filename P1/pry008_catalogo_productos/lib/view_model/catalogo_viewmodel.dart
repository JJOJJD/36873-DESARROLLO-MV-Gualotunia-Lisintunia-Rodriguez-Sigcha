import 'package:flutter/material.dart';
import '../model/producto_model.dart';

class CatalogoViewModel extends ChangeNotifier {
  final List<ProductoModelo> _productos = [
    ProductoModelo(
      id: 1,
      nombre: 'Laptop Gamer Victus',
      precio: 899.99,
      descripcion: 'Intel Core i7, 16GB RAM, 512GB SSD, Tarjeta gráfica RTX 4050.',
      categoria: 'Laptops',
      imagenes: [
        'assets/images/laptop1.png',
        'assets/images/laptop2.png',
      ],
    ),
    ProductoModelo(
      id: 2,
      nombre: 'Audífonos Bluetooth Pro',
      precio: 49.50,
      descripcion: 'Cancelación activa de ruido, batería 30 horas, sonido estéreo HD.',
      categoria: 'Audio',
      imagenes: [
        'assets/images/auriculares1.png',
        'assets/images/auriculares2.png',
      ],
    ),
    ProductoModelo(
      id: 3,
      nombre: 'Reloj Smartwatch Fit',
      precio: 35.00,
      descripcion: 'Monitor de ritmo cardíaco, podómetro, resistente al agua IP68.',
      categoria: 'Accesorios',
      imagenes: [
        'assets/images/reloj1.png',
        'assets/images/reloj2.png',
      ],
    ),
    ProductoModelo(
      id: 4,
      nombre: 'Teclado Mecánico RGB',
      precio: 65.00,
      descripcion: 'Switches azules mecánicos, retroiluminación RGB personalizable.',
      categoria: 'Accesorios',
      imagenes: [
        'assets/images/teclado1.png',
        'assets/images/teclado2.png',
      ],
    ),
  ];

  final Set<int> _favoritosIds = {};

  List<ProductoModelo> get productos => _productos;
  Set<int> get favoritosIds => _favoritosIds;

  bool esFavorito(int id) {
    return _favoritosIds.contains(id);
  }

  void alternarFavorito(int id) {
    if (_favoritosIds.contains(id)) {
      _favoritosIds.remove(id);
    } else {
      _favoritosIds.add(id);
    }
    notifyListeners();
  }
}

