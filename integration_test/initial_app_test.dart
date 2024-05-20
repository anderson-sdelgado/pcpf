import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/main.dart' as app;
import 'package:pcp/presenter/initial/menu_inicial/menu_inicial_page.dart';
import 'package:pcp/presenter/initial/senha/view/senha_form.dart';
import 'package:pcp/presenter/initial/senha/view/senha_page.dart';

void main() async {

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    setup();
  });

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Teste de Acesso Inicial', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    expect(find.byType(MenuInicialPage), findsOneWidget);
  });


  testWidgets('Teste de Acesso Tela de Senha', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    await tester.tap(find.byKey(const Key(KEY_CONFIG_MENU_INICIAL_ITEM)));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    expect(find.byType(SenhaPage), findsOneWidget);
  });

  testWidgets('Teste de Acesso Configurações', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    await tester.tap(find.byKey(const Key(KEY_CONFIG_MENU_INICIAL_ITEM)));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    await tester.tap(find.byKey(const Key(KEY_OK_SENHA_BUTTON)));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    expect(find.text('ATUALIZAR DADOS'), findsOneWidget);
  });

}