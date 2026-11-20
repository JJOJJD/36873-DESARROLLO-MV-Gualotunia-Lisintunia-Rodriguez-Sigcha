import '../entities/bien.dart';
import '../entities/entrega.dart';
import '../entities/responsable.dart';
import '../repositories/almacen_repository.dart';

class GestionarAlmacenUseCases {
  final AlmacenRepository repository;

  GestionarAlmacenUseCases(this.repository);

  Future<bool> verificarConexion() => repository.verificarConexionApi();

  Future<List<Responsable>> obtenerResponsables() =>
      repository.obtenerResponsables();

  Future<Responsable> crearResponsable(Responsable responsable) =>
      repository.crearResponsable(responsable);

  Future<List<Bien>> obtenerBienes() => repository.obtenerBienes();

  Future<Bien> crearBien(Bien bien) => repository.crearBien(bien);

  Future<Bien> actualizarEstadoBien(int bienId, String nuevoEstado) =>
      repository.actualizarEstadoBien(bienId, nuevoEstado);

  Future<List<Entrega>> obtenerEntregas() => repository.obtenerEntregas();

  Future<({Entrega entrega, Bien bien})> registrarEntrega({
    required int bienId,
    required int responsableId,
    required String tipoEntrega,
    required String fecha,
    required int cantidad,
    required String condicionEntrega,
    required String observacion,
    String? fotoPath,
  }) =>
      repository.registrarEntrega(
        bienId: bienId,
        responsableId: responsableId,
        tipoEntrega: tipoEntrega,
        fecha: fecha,
        cantidad: cantidad,
        condicionEntrega: condicionEntrega,
        observacion: observacion,
        fotoPath: fotoPath,
      );

  Future<({Entrega entrega, Bien bien})> registrarDevolucion({
    required int entregaId,
    required String condicionDevolucion,
    required bool presentaDano,
    required String fechaDevolucion,
  }) =>
      repository.registrarDevolucion(
        entregaId: entregaId,
        condicionDevolucion: condicionDevolucion,
        presentaDano: presentaDano,
        fechaDevolucion: fechaDevolucion,
      );
}
