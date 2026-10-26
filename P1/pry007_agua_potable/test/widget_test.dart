import 'package:flutter_test/flutter_test.dart';
import 'package:pry007_agua_potable/main.dart';

void main() {
  testWidgets('Carga inicial de pantalla de login y botones de acción', (WidgetTester tester) async {
    await tester.pumpWidget(const AguaPotableApp());
    expect(find.text('Portal de Abonados'), findsOneWidget);
    expect(find.text('Iniciar Sesión'), findsOneWidget);
    expect(find.text('Limpiar'), findsOneWidget);
  });
}
