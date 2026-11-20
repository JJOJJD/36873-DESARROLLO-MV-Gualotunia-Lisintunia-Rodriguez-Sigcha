import '../entities/bien.dart';
import '../entities/entrega.dart';
import '../entities/responsable.dart';

abstract class AlmacenRepository {
  Future<bool> verificarConexionApi();

  Future<List<Responsable>> obtenerResponsables();
  Future<Responsable> crearResponsable(Responsable responsable);

  Future<List<Bien>> obtenerBienes();
  Future<Bien> crearBien(Bien bien);
  Future<Bien> actualizarEstadoBien(int bienId, String nuevoEstado);

  Future<List<Entrega>> obtenerEntregas();
  Future<({Entrega entrega, Bien bien})> registrarEntrega({
    required int bienId,
    required int responsableId,
    required String tipoEntrega,
    required String fecha,
    required int cantidad,
    required String condicionEntrega,
    required String observacion,
    String? fotoPath,
  });

  Future<({Entrega entrega, Bien bien})> registrarDevolucion({
    required int entregaId,
    required String condicionDevolucion,
    required bool presentaDano,
    required String fechaDevolucion,
  });
}
