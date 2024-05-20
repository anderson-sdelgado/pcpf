import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/app_widget.dart';

main() {

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    setup();
  });

  group('Test MenuInicialPage', () {
    testWidgets('Verificar itens Menu Inicial', (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      await tester.pumpWidget(const AppWidget());
      await tester.pumpAndSettle();

      expect(find.text('APONTAMENTO'), findsOneWidget);
      expect(find.text('CONFIGURAÇÃO'), findsOneWidget);
      expect(find.text('SAIR'), findsOneWidget);
    });
  });
}
