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
    final r = logica.banco('1000; 0; 0');
    expect(r, contains('saldo actual \$1320.00'));
    expect(r, contains('Ganancia por intereses de morosos: \$120.00'));
  });
}
