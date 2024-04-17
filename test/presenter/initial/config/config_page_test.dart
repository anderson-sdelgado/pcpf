import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/app_widget.dart';
import 'package:pcp/presenter/initial/config/config_page.dart';
import 'package:pcp/presenter/initial/menu_inicial/menu_inicial_page.dart';

void main() {
  group("Test ConfigPage", () {
    final modularApp = ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    );
    Modular.setInitialRoute('/config');

    testWidgets("Verificar itens da tela Configuração",
        (WidgetTester tester) async {
      await tester.pumpWidget(modularApp);
      await tester.pumpAndSettle();

      expect(find.byType(ConfigPage), findsOneWidget);
      expect(find.text('NRO APARELHO'), findsOneWidget);
      expect(find.text('SENHA'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
      expect(find.text('CANCELAR'), findsOneWidget);
      expect(find.text('ATUALIZAR DADOS'), findsOneWidget);
    });

    testWidgets("Verificar nro do aparelho e senha digitada",
        (WidgetTester tester) async {
      await tester.pumpWidget(modularApp);
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byKey(const Key(KEY_NRO_APARELHO_CONFIG_TEXT_FIELD)),
          '16997417840');
      await tester.pumpAndSettle();

      var nroAparelho = find
          .byKey(const Key(KEY_NRO_APARELHO_CONFIG_TEXT_FIELD))
          .evaluate()
          .single
          .widget as TextField;
      expect(nroAparelho.controller!.text, equals('16997417840'));

      await tester.enterText(
          find.byKey(const Key(KEY_SENHA_CONFIG_TEXT_FIELD)), '12345');
      await tester.pumpAndSettle();

      var senha = find
          .byKey(const Key(KEY_SENHA_CONFIG_TEXT_FIELD))
          .evaluate()
          .single
          .widget as TextField;
      expect(senha.controller!.text, equals('12345'));
    });

    testWidgets("Verificar botão cancelar foi clicado",
        (WidgetTester tester) async {
      await tester.pumpWidget(modularApp);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key(KEY_CANCELAR_CONFIG_BUTTON)));
      await tester.pumpAndSettle();

      expect(find.byType(MenuInicialPage), findsOneWidget);
    });

    testWidgets(
        "Verificar msg quando nro do aparelho e senha não for digitado e o botão ok foi clicado",
        (WidgetTester tester) async {
      await tester.pumpWidget(modularApp);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key(KEY_OK_CONFIG_BUTTON)));
      await tester.pumpAndSettle();

      expect(find.text("ATENÇÃO"), findsOneWidget);
      expect(find.text("CAMPO VAZIO! POR FAVOR, PREENCHA TODOS OS CAMPOS PARA SALVAR AS CONFIGURAÇÕES."), findsOneWidget);
    });
  });
}
