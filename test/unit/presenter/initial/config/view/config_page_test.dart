import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/app_widget.dart';
import 'package:pcp/presenter/initial/config/cubit/config_cubit.dart';
import 'package:pcp/presenter/initial/config/view/config_form.dart';
import 'package:pcp/presenter/initial/config/view/config_page.dart';
import 'package:pcp/presenter/initial/config/cubit/config_states.dart';
import 'package:pcp/presenter/initial/menu_inicial/view/menu_inicial_page.dart';

class MockConfigCubit extends MockCubit<ConfigStates> implements ConfigCubit {}

class MockConfigStates extends Fake implements ConfigStates {}

void main() {
  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    setup();
  });

  group("Test ConfigPage", () {
    testWidgets("Verificar itens da tela Configuração",
        (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      await tester.pumpWidget(const AppWidget(
        urlInitial: "/config",
      ));
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
      await tester.runAsync(getIt.allReady);
      await tester.pumpWidget(const AppWidget(
        urlInitial: "/config",
      ));
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
      await tester.runAsync(getIt.allReady);
      await tester.pumpWidget(const AppWidget(
        urlInitial: "/config",
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key(KEY_CANCELAR_CONFIG_BUTTON)));
      await tester.pumpAndSettle();

      expect(find.byType(MenuInicialPage), findsOneWidget);
    });

    testWidgets(
        "Verificar msg quando nro do aparelho e senha não for digitado e o botão ok foi clicado",
        (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      await tester.pumpWidget(const AppWidget(
        urlInitial: "/config",
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key(KEY_OK_CONFIG_BUTTON)));
      await tester.pumpAndSettle();

      expect(find.text("ATENÇÃO"), findsOneWidget);
      expect(
          find.text(
              "CAMPO VAZIO! POR FAVOR, PREENCHA TODOS OS CAMPOS PARA SALVAR AS CONFIGURAÇÕES."),
          findsOneWidget);
    });

    testWidgets(
        "Verificar msg quando senha não for digitado e o botão ok foi clicado",
        (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      await tester.pumpWidget(const AppWidget(
        urlInitial: "/config",
      ));
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byKey(const Key(KEY_NRO_APARELHO_CONFIG_TEXT_FIELD)),
          '16997417840');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key(KEY_OK_CONFIG_BUTTON)));
      await tester.pumpAndSettle();

      expect(find.text("ATENÇÃO"), findsOneWidget);
      expect(
          find.text(
              "CAMPO VAZIO! POR FAVOR, PREENCHA TODOS OS CAMPOS PARA SALVAR AS CONFIGURAÇÕES."),
          findsOneWidget);
    });

    testWidgets(
        "Verificar msg quando aparelho não for digitado e o botão ok foi clicado",
        (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      await tester.pumpWidget(const AppWidget(
        urlInitial: "/config",
      ));
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byKey(const Key(KEY_SENHA_CONFIG_TEXT_FIELD)), '12345');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key(KEY_OK_CONFIG_BUTTON)));
      await tester.pumpAndSettle();

      expect(find.text("ATENÇÃO"), findsOneWidget);
      expect(
          find.text(
              "CAMPO VAZIO! POR FAVOR, PREENCHA TODOS OS CAMPOS PARA SALVAR AS CONFIGURAÇÕES."),
          findsOneWidget);
    });

    testWidgets("Estado inicial", (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      registerFallbackValue(MockConfigStates());
      ConfigCubit configCubit = MockConfigCubit();
      when(() => configCubit.state).thenReturn(InitialConfigStates());

      await tester.pumpWidget(const AppWidget(
        urlInitial: "/config",
      ));
      await tester.pumpAndSettle();

      expect(configCubit.state, InitialConfigStates());
    });

    testWidgets("Verificar retorno de envio de dados de token",
        (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      registerFallbackValue(MockConfigStates());
      ConfigCubit configCubit = MockConfigCubit();
      await getIt.unregister<ConfigCubit>();
      getIt.registerFactory<ConfigCubit>(() => configCubit);
      when(() => configCubit.state).thenReturn(InitialConfigStates());

      whenListen(
          configCubit,
          Stream.fromIterable([
            InitialConfigStates(),
            SendConfigStates(),
          ]));

      await tester.pumpWidget(const AppWidget(
        urlInitial: "/config",
      ));
      await tester.pumpAndSettle();

      expect(find.text("Enviar Dados de Token"), findsOneWidget);
    });
  });
}
