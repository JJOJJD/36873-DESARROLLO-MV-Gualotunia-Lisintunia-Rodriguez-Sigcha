import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:pry006_dart_g2/logica/ejercicios_logica.dart';
import 'package:pry006_dart_g2/main.dart';

void main() {
  final logica = EjerciciosLogica();

  testWidgets('El menú muestra los ejercicios', (tester) async {
    await tester.pumpWidget(const EjerciciosApp());
    expect(find.text('6. Impuesto de vehículos'), findsOneWidget);
    expect(find.text('10. Intervalo de números'), findsOneWidget);
  });

  test('vehículos', () {
    final r = logica.vehiculos('1; 1000\n2; 1000\n3; 1000');
    expect(r, contains('Total clave 1: \$100.00'));
    expect(r, contains('Total de todos los vehículos: \$220.00'));
  });

  test('banco: cliente moroso', () {
    // saldo 1000, pago 0 -> moroso: 1000 + 120 + 200 = 1320
    final r = logica.banco('1000; 0; 0');
    expect(r, contains('saldo actual \$1320.00'));
    expect(r, contains('Ganancia por intereses de morosos: \$120.00'));
  });

  test('ahorro acumulado', () {
    final r = logica.ahorro(List.filled(12, '100').join('\n'));
    expect(r, contains('Mes 3: depósito \$100.00, ahorrado \$300.00'));
    expect(r, contains('Ahorro del año: \$1200.00'));
    expect(() => logica.ahorro('100'), throwsFormatException);
  });

  test('intervalo', () {
    final r = logica.intervalo(['1', '10', '5\n1\n20\n7\n0\n99']);
    expect(r, contains('intervalo: 12.0'));
    expect(r, contains('fuera del intervalo: 2'));
    expect(r, contains('Sí se introdujo'));
    expect(() => logica.intervalo(['10', '1', '0']), throwsFormatException);
  });

  test('juego de adivinar', () {
    final juego = JuegoAdivinar(azar: Random(1));
    final n = juego.numeroSecreto;
    for (int i = 0; i < 9; i++) {
      juego.probar(n == 1 ? '2' : '1');
    }
    expect(juego.probar(n == 1 ? '2' : '1'), contains('era $n'));
    final otro = JuegoAdivinar(azar: Random(1));
    expect(otro.probar('${otro.numeroSecreto}'), contains('1 intentos'));
  });
}
