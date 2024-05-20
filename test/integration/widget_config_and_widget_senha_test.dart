import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/app_widget.dart';
import 'package:pcp/presenter/initial/menu_inicial/menu_inicial_page.dart';
import 'package:pcp/presenter/initial/senha/view/senha_form.dart';
import 'package:pcp/presenter/initial/senha/view/senha_page.dart';

main() {
  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    setup();
  });

  group('Test MenuInicialPage to SenhaPage', () {
    testWidgets('Verificar clique no item CONFIGURAÇÃO',
        (WidgetTester tester) async {
      await tester.pumpWidget(const AppWidget());
      await tester.pumpAndSettle();

      expect(find.text('APONTAMENTO'), findsOneWidget);
      expect(find.text('CONFIGURAÇÃO'), findsOneWidget);
      expect(find.text('SAIR'), findsOneWidget);

      expect(
          find.byKey(const Key(KEY_CONFIG_MENU_INICIAL_ITEM)), findsOneWidget);
      await tester.tap(find.byKey(const Key(KEY_CONFIG_MENU_INICIAL_ITEM)));
      await tester.pumpAndSettle();

      expect(find.byType(SenhaPage), findsOneWidget);
    });
  });

  group('Test SenhaPage to MenuInicialPage', () {
    testWidgets("Verificar retorno no clique do button Cancelar",
            (WidgetTester tester) async {
              await tester.pumpWidget(const AppWidget(
                urlInitial: "/senha",
              ));
          await tester.pumpAndSettle();

          expect(find.byKey(const Key(KEY_CANCELAR_SENHA_BUTTON)), findsOneWidget);
          await tester.tap(find.byKey(const Key(KEY_CANCELAR_SENHA_BUTTON)));
          await tester.pumpAndSettle();

          expect(find.text('APONTAMENTO'), findsOneWidget);
          expect(find.text('CONFIGURAÇÃO'), findsOneWidget);
          expect(find.text('SAIR'), findsOneWidget);
        });
  });

}
