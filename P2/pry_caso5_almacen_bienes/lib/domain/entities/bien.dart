class EstadoBien {
  static const String disponible = 'Disponible';
  static const String entregado = 'Entregado';
  static const String enMantenimiento = 'En mantenimiento';
  static const String dadoDeBaja = 'Dado de baja';

  static const List<String> valores = [
    disponible,
    entregado,
    enMantenimiento,
    dadoDeBaja,
  ];
}

class Bien {
  final int id;
  final String codigoInstitucional;
  final String nombre;
  final String categoria;
  final int cantidadDisponible;
  final int cantidadTotal;
  final String estado;

  const Bien({
    required this.id,
    required this.codigoInstitucional,
    required this.nombre,
    required this.categoria,
    required this.cantidadDisponible,
    required this.cantidadTotal,
    required this.estado,
  });

  bool get puedeEntregarse =>
      estado == EstadoBien.disponible && cantidadDisponible > 0;

  Bien copyWith({
    int? id,
    String? codigoInstitucional,
    String? nombre,
    String? categoria,
    int? cantidadDisponible,
    int? cantidadTotal,
    String? estado,
  }) {
    return Bien(
      id: id ?? this.id,
      codigoInstitucional: codigoInstitucional ?? this.codigoInstitucional,
      nombre: nombre ?? this.nombre,
      categoria: categoria ?? this.categoria,
      cantidadDisponible: cantidadDisponible ?? this.cantidadDisponible,
      cantidadTotal: cantidadTotal ?? this.cantidadTotal,
      estado: estado ?? this.estado,
    );
  }
}
