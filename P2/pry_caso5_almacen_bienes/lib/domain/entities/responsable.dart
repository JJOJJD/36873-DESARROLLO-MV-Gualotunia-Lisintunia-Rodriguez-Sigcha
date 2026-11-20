class Responsable {
  final int id;
  final String nombre;
  final String tipo; // Docente, Laboratorio, Oficina, Responsable de Proyecto
  final String departamento;
  final String correo;

  const Responsable({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.departamento,
    required this.correo,
  });
}
