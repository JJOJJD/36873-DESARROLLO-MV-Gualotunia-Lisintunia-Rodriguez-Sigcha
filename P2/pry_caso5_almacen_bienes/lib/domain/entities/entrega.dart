class Entrega {
  final int id;
  final int bienId;
  final String bienCodigo;
  final String bienNombre;
  final int responsableId;
  final String responsableNombre;
  final String tipoEntrega; // Temporal o Definitiva
  final String fecha;
  final int cantidad;
  final String condicionEntrega;
  final String observacion;
  final bool devuelta;
  final String? fechaDevolucion;
  final String? condicionDevolucion;
  final bool presentaDano;
  final String? fotoPath;

  const Entrega({
    required this.id,
    required this.bienId,
    required this.bienCodigo,
    required this.bienNombre,
    required this.responsableId,
    required this.responsableNombre,
    required this.tipoEntrega,
    required this.fecha,
    required this.cantidad,
    required this.condicionEntrega,
    required this.observacion,
    this.devuelta = false,
    this.fechaDevolucion,
    this.condicionDevolucion,
    this.presentaDano = false,
    this.fotoPath,
  });

  Entrega copyWith({
    bool? devuelta,
    String? fechaDevolucion,
    String? condicionDevolucion,
    bool? presentaDano,
  }) {
    return Entrega(
      id: id,
      bienId: bienId,
      bienCodigo: bienCodigo,
      bienNombre: bienNombre,
      responsableId: responsableId,
      responsableNombre: responsableNombre,
      tipoEntrega: tipoEntrega,
      fecha: fecha,
      cantidad: cantidad,
      condicionEntrega: condicionEntrega,
      observacion: observacion,
      devuelta: devuelta ?? this.devuelta,
      fechaDevolucion: fechaDevolucion ?? this.fechaDevolucion,
      condicionDevolucion: condicionDevolucion ?? this.condicionDevolucion,
      presentaDano: presentaDano ?? this.presentaDano,
      fotoPath: fotoPath,
    );
  }
}
