import 'package:flutter_test/flutter_test.dart';
import 'package:pry007_agua_potable/main.dart';
import 'package:pry007_agua_potable/controlador/agua_controlador.dart';

void main() {
  testWidgets('Carga inicial de pantalla de login', (WidgetTester tester) async {
    await tester.pumpWidget(const AguaPotableApp());
    expect(find.text('Portal de Abonados'), findsOneWidget);
    expect(find.text('Iniciar Sesión'), findsOneWidget);
    expect(find.text('Limpiar'), findsOneWidget);
  });

  test('Prueba 1: Cálculo tarifario residencial en rango básico (0 a 15 m³)', () {
    final controlador = AguaControlador();
    final res = controlador.liquidarConsumo(
      numeroCuenta: 'CTA-101',
      nombreCliente: 'Juan Perez',
      lecturaAnterior: 100.0,
      lecturaActual: 112.0, // 12 m³
      tipoConsumidor: 'Residencial',
    );

    expect(res.consumoM3, 12.0);
    expect(res.tarifaPorM3, 0.35);
    expect(res.valorConsumo, closeTo(4.20, 0.001));
    expect(res.cargoFijo, 2.50);
    expect(res.subtotal, closeTo(6.70, 0.001));
    expect(res.recargo, closeTo(0.67, 0.001));
    expect(res.totalPagar, closeTo(7.37, 0.001));
  });

  test('Prueba 2: Cálculo tarifario residencial en rango intermedio (16 a 30 m³)', () {
    final controlador = AguaControlador();
    final res = controlador.liquidarConsumo(
      numeroCuenta: 'CTA-102',
      nombreCliente: 'Maria Lopez',
      lecturaAnterior: 200.0,
      lecturaActual: 225.0, // 25 m³
      tipoConsumidor: 'Residencial',
    );

    expect(res.consumoM3, 25.0);
    expect(res.tarifaPorM3, 0.60);
    expect(res.valorConsumo, closeTo(15.00, 0.001));
    expect(res.cargoFijo, 2.50);
    expect(res.subtotal, closeTo(17.50, 0.001));
    expect(res.recargo, closeTo(1.75, 0.001));
    expect(res.totalPagar, closeTo(19.25, 0.001));
  });

  test('Prueba 3: Cálculo tarifario comercial en rango superior (> 30 m³)', () {
    final controlador = AguaControlador();
    final res = controlador.liquidarConsumo(
      numeroCuenta: 'COM-501',
      nombreCliente: 'Restaurante Central',
      lecturaAnterior: 500.0,
      lecturaActual: 545.0, // 45 m³
      tipoConsumidor: 'Comercial',
    );

    expect(res.consumoM3, 45.0);
    expect(res.tarifaPorM3, 1.25);
    expect(res.valorConsumo, closeTo(56.25, 0.001));
    expect(res.cargoFijo, 4.00);
    expect(res.subtotal, closeTo(60.25, 0.001));
    expect(res.recargo, closeTo(6.025, 0.001));
    expect(res.totalPagar, closeTo(66.275, 0.001));
  });

  test('Prueba 4: Validación de lecturas inconsistentes (actual menor a anterior)', () {
    final controlador = AguaControlador();
    final error = controlador.validarLecturas(150.0, 120.0);
    expect(error, contains('no puede ser menor'));
  });

  test('Prueba 5: Validación de campos obligatorios vacíos', () {
    final controlador = AguaControlador();
    final error = controlador.validarCamposRequeridos(
      cuenta: '',
      cliente: 'Carlos',
      anterior: '10',
      actual: '20',
    );
    expect(error, contains('número de cuenta es obligatorio'));
  });
}
