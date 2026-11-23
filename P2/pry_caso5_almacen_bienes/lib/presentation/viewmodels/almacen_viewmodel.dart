import 'package:flutter/material.dart';
import '../../domain/entities/bien.dart';
import '../../domain/entities/entrega.dart';
import '../../domain/entities/responsable.dart';
import '../../domain/usecases/gestionar_almacen_usecases.dart';

class AlmacenViewModel extends ChangeNotifier {
  final GestionarAlmacenUseCases useCases;

  AlmacenViewModel(this.useCases);

  List<Responsable> _responsables = [];
  List<Bien> _bienes = [];
  List<Entrega> _entregas = [];

  bool _cargando = false;
  bool _apiEnLinea = false;
  String? _error;
  String _filtroEstado = 'Todos';

  List<Responsable> get responsables => _responsables;
  List<Bien> get bienes => _bienes;
  List<Entrega> get entregas => _entregas;
  bool get cargando => _cargando;
  bool get apiEnLinea => _apiEnLinea;
  String? get error => _error;
  String get filtroEstado => _filtroEstado;

  List<Bien> get bienesFiltrados {
    if (_filtroEstado == 'Todos') return _bienes;
    return _bienes.where((b) => b.estado == _filtroEstado).toList();
  }

  List<Bien> get bienesDisponibles =>
      _bienes.where((b) => b.puedeEntregarse).toList();

  int contarPorEstado(String estado) =>
      _bienes.where((b) => b.estado == estado).length;

  int get entregasActivas => _entregas.where((e) => !e.devuelta).length;

  void cambiarFiltroEstado(String nuevoFiltro) {
    _filtroEstado = nuevoFiltro;
    notifyListeners();
  }

  void limpiarError() {
    _error = null;
    notifyListeners();
  }

  Future<void> cargarDatosIniciales() async {
    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      _apiEnLinea = await useCases.verificarConexion();
      final resultados = await Future.wait([
        useCases.obtenerResponsables(),
        useCases.obtenerBienes(),
        useCases.obtenerEntregas(),
      ]);
      _responsables = resultados[0] as List<Responsable>;
      _bienes = resultados[1] as List<Bien>;
      _entregas = resultados[2] as List<Entrega>;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  Future<String?> agregarResponsable({
    required String nombre,
    required String tipo,
    required String departamento,
    required String correo,
  }) async {
    if (nombre.trim().isEmpty || departamento.trim().isEmpty) {
      return 'Nombre y departamento son obligatorios.';
    }
    try {
      final nuevo = await useCases.crearResponsable(
        Responsable(
          id: 0,
          nombre: nombre.trim(),
          tipo: tipo,
          departamento: departamento.trim(),
          correo: correo.trim(),
        ),
      );
      _responsables.add(nuevo);
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString().replaceFirst('Exception: ', '');
    }
  }

  Future<String?> agregarBien({
    required String codigoInstitucional,
    required String nombre,
    required String categoria,
    required int cantidad,
  }) async {
    final codigo = codigoInstitucional.trim().toUpperCase();
    if (codigo.isEmpty || nombre.trim().isEmpty) {
      return 'Código institucional y nombre son obligatorios.';
    }
    if (_bienes.any((b) => b.codigoInstitucional.toUpperCase() == codigo)) {
      return 'El código institucional $codigo ya está registrado.';
    }
    if (cantidad <= 0) {
      return 'La cantidad disponible debe ser mayor a 0.';
    }

    try {
      final nuevo = await useCases.crearBien(
        Bien(
          id: 0,
          codigoInstitucional: codigo,
          nombre: nombre.trim(),
          categoria: categoria.trim().isEmpty ? 'General' : categoria.trim(),
          cantidadDisponible: cantidad,
          cantidadTotal: cantidad,
          estado: EstadoBien.disponible,
        ),
      );
      _bienes.add(nuevo);
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString().replaceFirst('Exception: ', '');
    }
  }

  Future<String?> cambiarEstadoBien(int bienId, String nuevoEstado) async {
    final idx = _bienes.indexWhere((b) => b.id == bienId);
    if (idx == -1) return 'Bien no encontrado.';
    if (_bienes[idx].estado == EstadoBien.dadoDeBaja &&
        nuevoEstado != EstadoBien.dadoDeBaja) {
      return 'Un bien dado de baja no puede volver a entregarse ni reactivarse.';
    }

    try {
      final actualizado =
          await useCases.actualizarEstadoBien(bienId, nuevoEstado);
      _bienes[idx] = actualizado;
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString().replaceFirst('Exception: ', '');
    }
  }

  Future<String?> registrarEntrega({
    required int bienId,
    required int responsableId,
    required String tipoEntrega,
    required String fecha,
    required int cantidad,
    required String condicionEntrega,
    required String observacion,
    String? fotoPath,
  }) async {
    final bIdx = _bienes.indexWhere((b) => b.id == bienId);
    if (bIdx == -1) return 'Debe seleccionar un bien válido.';
    final bien = _bienes[bIdx];

    if (bien.estado == EstadoBien.dadoDeBaja) {
      return 'Un bien dado de baja no puede volver a entregarse.';
    }
    if (bien.estado != EstadoBien.disponible) {
      return 'El bien solo puede entregarse si su estado es Disponible.';
    }
    if (!_responsables.any((r) => r.id == responsableId)) {
      return 'Toda entrega debe estar asociada a un responsable.';
    }
    if (cantidad <= 0) {
      return 'La cantidad entregada debe ser mayor a 0.';
    }
    if (cantidad > bien.cantidadDisponible) {
      return 'La cantidad ($cantidad) supera el stock disponible (${bien.cantidadDisponible}).';
    }
    if (condicionEntrega.trim().isEmpty) {
      return 'Debe registrar la condición de entrega del bien.';
    }

    try {
      final res = await useCases.registrarEntrega(
        bienId: bienId,
        responsableId: responsableId,
        tipoEntrega: tipoEntrega,
        fecha: fecha,
        cantidad: cantidad,
        condicionEntrega: condicionEntrega.trim(),
        observacion: observacion.trim(),
        fotoPath: fotoPath,
      );
      _bienes[bIdx] = res.bien;
      _entregas.insert(0, res.entrega);
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString().replaceFirst('Exception: ', '');
    }
  }

  Future<String?> registrarDevolucion({
    required int entregaId,
    required String condicionDevolucion,
    required bool presentaDano,
  }) async {
    if (condicionDevolucion.trim().isEmpty) {
      return 'Debe registrar la condición de devolución del bien.';
    }
    final eIdx = _entregas.indexWhere((e) => e.id == entregaId);
    if (eIdx == -1) return 'Entrega no encontrada.';

    final hoy = DateTime.now().toIso8601String().split('T').first;
    try {
      final res = await useCases.registrarDevolucion(
        entregaId: entregaId,
        condicionDevolucion: condicionDevolucion.trim(),
        presentaDano: presentaDano,
        fechaDevolucion: hoy,
      );
      _entregas[eIdx] = res.entrega;
      final bIdx = _bienes.indexWhere((b) => b.id == res.bien.id);
      if (bIdx != -1) {
        _bienes[bIdx] = res.bien;
      }
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString().replaceFirst('Exception: ', '');
    }
  }
}
