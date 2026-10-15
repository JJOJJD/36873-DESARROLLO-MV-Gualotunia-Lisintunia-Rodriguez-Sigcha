class EjerciciosLogica {
  double numero(String texto, {bool permitirNegativos = false}) {
    final valor = double.tryParse(texto.trim().replaceAll(',', '.'));
    if (valor == null || !valor.isFinite || (!permitirNegativos && valor < 0)) {
      throw FormatException(
        permitirNegativos
            ? 'Ingresa números válidos.'
            : 'Ingresa números válidos, no negativos.',
      );
    }
    return valor;
  }

  List<String> filas(String texto) {
    final lista = texto
        .trim()
        .split('\n')
        .where((f) => f.trim().isNotEmpty)
        .toList();
    if (lista.isEmpty) {
      throw const FormatException('Ingresa al menos un registro.');
    }
    return lista;
  }

  String dinero(double valor) {
    if (!valor.isFinite) {
      throw const FormatException('El resultado es demasiado grande.');
    }
    return '\$${valor.toStringAsFixed(2)}';
  }

  String vehiculos(String texto) {
    const tasas = {1: 0.10, 2: 0.07, 3: 0.05};
    final totales = {1: 0.0, 2: 0.0, 3: 0.0};
    final detalle = <String>[];
    int numeroVehiculo = 0;
    for (final fila in filas(texto)) {
      final datos = fila.split(';');
      final clave = datos.length == 2 ? int.tryParse(datos[0].trim()) : null;
      if (clave == null || !tasas.containsKey(clave)) {
        throw const FormatException(
          'Formato por línea: clave (1, 2 o 3); valor del vehículo.',
        );
      }
      final impuesto = numero(datos[1]) * tasas[clave]!;
      totales[clave] = totales[clave]! + impuesto;
      detalle.add(
        'Vehículo ${++numeroVehiculo} (clave $clave): impuesto ${dinero(impuesto)}',
      );
    }
    return [
      ...detalle,
      for (final clave in tasas.keys)
        'Total clave $clave: ${dinero(totales[clave]!)}',
      'Total de todos los vehículos: ${dinero(totales.values.reduce((a, b) => a + b))}',
    ].join('\n');
  }

  String banco(String texto) {
    double ganancia = 0;
    int morosos = 0;
    final detalle = <String>[];
    int numeroCliente = 0;
    for (final fila in filas(texto)) {
      final datos = fila.split(';');
      if (datos.length != 3) {
        throw const FormatException(
          'Formato por línea: saldo anterior; compras; pago.',
        );
      }
      final anterior = numero(datos[0]);
      final compras = numero(datos[1]);
      final pago = numero(datos[2]);
      double saldo = anterior + compras - pago;
      if (saldo < 0) saldo = 0;
      final moroso = pago < saldo * 0.15;
      if (moroso) {
        final interes = saldo * 0.12;
        saldo += interes + 200;
        ganancia += interes;
        morosos++;
      }
      detalle.add(
        'Cliente ${++numeroCliente}${moroso ? ' (moroso)' : ''}: saldo actual ${dinero(saldo)}, pago mínimo ${dinero(saldo * 0.15)}, pago para no generar intereses ${dinero(saldo * 0.85)}',
      );
    }
    return [
      ...detalle,
      'Clientes morosos: $morosos',
      'Ganancia por intereses de morosos: ${dinero(ganancia)}',
    ].join('\n');
  }
}
