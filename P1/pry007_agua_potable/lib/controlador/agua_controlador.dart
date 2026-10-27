import '../modelo/consumo_modelo.dart';

/// Controlador MVC: Contiene las reglas de negocio, validaciones y calculos tarifarios
class AguaControlador {
  /// Valida que ningun campo de texto este vacio
  String? validarCamposRequeridos({
    required String cuenta,
    required String cliente,
    required String anterior,
    required String actual,
  }) {
    if (cuenta.trim().isEmpty) return 'El número de cuenta es obligatorio.';
    if (cliente.trim().isEmpty) return 'El nombre del cliente es obligatorio.';
    if (anterior.trim().isEmpty) return 'La lectura anterior es obligatoria.';
    if (actual.trim().isEmpty) return 'La lectura actual es obligatoria.';
    return null;
  }

  /// Valida la logica de las lecturas del medidor
  String? validarLecturas(double anterior, double actual) {
    if (anterior < 0) {
      return 'La lectura anterior no puede ser negativa.';
    }
    if (actual < 0) {
      return 'La lectura actual no puede ser negativa.';
    }
    if (actual < anterior) {
      return 'La lectura actual ($actual) no puede ser menor a la anterior ($anterior).';
    }
    return null;
  }

  /// Realiza el calculo completo de la planilla de agua
  ConsumoAguaModelo liquidarConsumo({
    required String numeroCuenta,
    required String nombreCliente,
    required double lecturaAnterior,
    required double lecturaActual,
    required String tipoConsumidor,
  }) {
    // 1. Calculo del consumo volumetrico
    final double consumoM3 = lecturaActual - lecturaAnterior;

    // 2. Determinacion de tarifas y rangos segun tipo de consumidor
    final bool esResidencial = tipoConsumidor.toLowerCase() == 'residencial';

    double tarifaPorM3;
    String rangoConsumo;

    if (consumoM3 <= 15) {
      rangoConsumo = '0 a 15 m³ (Básica)';
      tarifaPorM3 = esResidencial ? 0.35 : 0.50;
    } else if (consumoM3 <= 30) {
      rangoConsumo = '16 a 30 m³ (Intermedia)';
      tarifaPorM3 = esResidencial ? 0.60 : 0.85;
    } else {
      rangoConsumo = 'Más de 30 m³ (Superior)';
      tarifaPorM3 = esResidencial ? 0.95 : 1.25;
    }

    // 3. Cargos fijos por servicio de mantenimiento de red
    final double cargoFijo = esResidencial ? 2.50 : 4.00;

    // 4. Valor del consumo y subtotal
    final double valorConsumo = consumoM3 * tarifaPorM3;
    final double subtotal = valorConsumo + cargoFijo;

    // 5. Recargo del 10% por tratamiento y alcantarillado
    const double porcentajeRecargo = 0.10;
    final double recargo = subtotal * porcentajeRecargo;

    // 6. Total a pagar
    final double totalPagar = subtotal + recargo;

    return ConsumoAguaModelo(
      numeroCuenta: numeroCuenta.trim(),
      nombreCliente: nombreCliente.trim(),
      lecturaAnterior: lecturaAnterior,
      lecturaActual: lecturaActual,
      tipoConsumidor: tipoConsumidor,
      consumoM3: consumoM3,
      tarifaPorM3: tarifaPorM3,
      rangoConsumo: rangoConsumo,
      valorConsumo: valorConsumo,
      cargoFijo: cargoFijo,
      subtotal: subtotal,
      porcentajeRecargo: porcentajeRecargo,
      recargo: recargo,
      totalPagar: totalPagar,
      fechaCalculo: DateTime.now(),
    );
  }
}
