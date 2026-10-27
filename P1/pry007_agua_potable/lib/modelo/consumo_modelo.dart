/// Modelo MVC: Representa la informacion del consumo de agua y su calculo financiero
class ConsumoAguaModelo {
  final String numeroCuenta;
  final String nombreCliente;
  final double lecturaAnterior;
  final double lecturaActual;
  final String tipoConsumidor; // 'Residencial' o 'Comercial'

  // Valores calculados
  final double consumoM3;
  final double tarifaPorM3;
  final String rangoConsumo;
  final double valorConsumo;
  final double cargoFijo;
  final double subtotal;
  final double porcentajeRecargo; // 0.10 (10%)
  final double recargo;
  final double totalPagar;
  final DateTime fechaCalculo;

  ConsumoAguaModelo({
    required this.numeroCuenta,
    required this.nombreCliente,
    required this.lecturaAnterior,
    required this.lecturaActual,
    required this.tipoConsumidor,
    required this.consumoM3,
    required this.tarifaPorM3,
    required this.rangoConsumo,
    required this.valorConsumo,
    required this.cargoFijo,
    required this.subtotal,
    required this.porcentajeRecargo,
    required this.recargo,
    required this.totalPagar,
    required this.fechaCalculo,
  });
}
