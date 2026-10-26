import 'dart:math';

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
      // Criterio: es moroso si su pago no cubre el 15% del saldo antes de recargos.
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

  String ahorro(String texto) {
    final depositos = filas(texto).map(numero).toList();
    if (depositos.length != 12) {
      throw const FormatException('Ingresa 12 depósitos, uno por mes.');
    }
    double acumulado = 0;
    final detalle = <String>[];
    for (int mes = 0; mes < 12; mes++) {
      acumulado += depositos[mes];
      detalle.add(
        'Mes ${mes + 1}: depósito ${dinero(depositos[mes])}, ahorrado ${dinero(acumulado)}',
      );
    }
    return [...detalle, 'Ahorro del año: ${dinero(acumulado)}'].join('\n');
  }

  String intervalo(List<String> datos) {
    final inferior = numero(datos[0], permitirNegativos: true);
    final superior = numero(datos[1], permitirNegativos: true);
    if (inferior > superior) {
      throw const FormatException(
        'El límite inferior es mayor que el superior. Vuelve a ingresarlos.',
      );
    }
    double suma = 0;
    int fuera = 0;
    bool igualALimite = false;
    for (final fila in filas(datos[2])) {
      final n = numero(fila, permitirNegativos: true);
      if (n == 0) break;
      if (n > inferior && n < superior) {
        suma += n;
      } else {
        fuera++;
        if (n == inferior || n == superior) igualALimite = true;
      }
    }
    return [
      'Suma de números dentro del intervalo: $suma',
      'Números fuera del intervalo: $fuera',
      igualALimite
          ? 'Sí se introdujo un número igual a un límite.'
          : 'No se introdujo ningún número igual a los límites.',
    ].join('\n');
  }
}

class JuegoAdivinar {
  static const intentosMaximos = 10;
  final Random _azar;
  late int numeroSecreto = _azar.nextInt(100) + 1;
  int intentos = 0;
  bool terminado = false;

  JuegoAdivinar({Random? azar}) : _azar = azar ?? Random();

  int get restantes => intentosMaximos - intentos;

  String probar(String texto) {
    final n = int.tryParse(texto.trim());
    if (n == null || n < 1 || n > 100) {
      throw const FormatException('Ingresa un entero entre 1 y 100.');
    }
    if (terminado) return 'El juego terminó. Reinícialo para jugar de nuevo.';
    intentos++;
    if (n == numeroSecreto) {
      terminado = true;
      return '¡Acertaste en $intentos intentos!';
    }
    if (restantes == 0) {
      terminado = true;
      return 'Se acabaron los intentos. El número era $numeroSecreto.';
    }
    return 'El número a adivinar es ${numeroSecreto > n ? 'mayor' : 'menor'}. Te quedan $restantes intentos.';
  }
}
