import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/app_widget.dart';
import 'package:pcp/domain/entities/variable/config.dart';
import 'package:pcp/infra/model/web_service/variable/config_web_service_model.dart';
import 'package:pcp/presenter/initial/config/view/config_form.dart';
import 'package:pcp/presenter/initial/menu_inicial/view/menu_inicial_form.dart';
import 'package:pcp/presenter/initial/menu_inicial/view/menu_inicial_page.dart';
import 'package:pcp/presenter/initial/senha/cubit/senha_cubit.dart';
import 'package:pcp/presenter/initial/senha/cubit/senha_states.dart';
import 'package:pcp/presenter/initial/senha/view/senha_form.dart';
import 'package:pcp/presenter/initial/senha/view/senha_page.dart';
import 'package:pcp/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../test/unit/presenter/initial/senha/view/senha_page_test.dart';
import '../test/utils/mock_dio.mocks.dart';

void main() async {
  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    setup();
  });

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Test WidgetInicial', () {
    testWidgets('Teste de Acesso Inicial', (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      await tester.pumpWidget(const AppWidget());
      await tester.pumpAndSettle();
      expect(find.byType(MenuInicialPage), findsOneWidget);
      await Future.delayed(const Duration(seconds: 2));
    });

    testWidgets('Teste de Acesso Tela de Senha', (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      await tester.pumpWidget(const AppWidget());
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(find.byKey(const Key(KEY_CONFIG_MENU_INICIAL_ITEM)));
      await tester.pumpAndSettle();
      expect(find.byType(SenhaPage), findsOneWidget);
      await Future.delayed(const Duration(seconds: 2));
    });

    testWidgets('Teste de Acesso Configurações', (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      await tester.pumpWidget(const AppWidget());
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(find.byKey(const Key(KEY_CONFIG_MENU_INICIAL_ITEM)));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(find.byKey(const Key(KEY_OK_SENHA_BUTTON)));
      await tester.pumpAndSettle();
      expect(find.text('ATUALIZAR DADOS'), findsOneWidget);
      await Future.delayed(const Duration(seconds: 2));
    });
  });

  group('Test WidgetSenha', () {
    testWidgets("Verificar retorno de Falha de Senha",
        (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      registerFallbackValue(MockSenhaStates());
      SenhaCubit senhaCubit = MockSenhaCubit();
      await getIt.unregister<SenhaCubit>();
      getIt.registerFactory<SenhaCubit>(() => senhaCubit);
      when(() => senhaCubit.state).thenReturn(InitialSenhaStates());

      whenListen(
          senhaCubit,
          Stream.fromIterable([
            InitialSenhaStates(),
            FailSenhaStates(),
          ]));

      await tester.pumpWidget(const AppWidget(
        urlInitial: "/senha",
      ));
      await tester.pumpAndSettle();
      expect(find.text("ATENÇÃO"), findsOneWidget);
      expect(find.text("SENHA INVÁLIDA!"), findsOneWidget);
      await Future.delayed(const Duration(seconds: 2));

    });

    testWidgets(
        "Verificar senha digitada no campo e butão clicado com senha invalida",
        (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      registerFallbackValue(MockSenhaStates());
      SenhaCubit senhaCubit = MockSenhaCubit();
      await getIt.unregister<SenhaCubit>();
      getIt.registerFactory<SenhaCubit>(() => senhaCubit);
      when(() => senhaCubit.state).thenReturn(InitialSenhaStates());
      when(() => senhaCubit.checkPassword("12345")).thenAnswer((_) async {
        when(() => senhaCubit.state).thenReturn(FailSenhaStates());
      });

      await tester.pumpWidget(const AppWidget(
        urlInitial: "/senha",
      ));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));

      await tester.enterText(
          find.byKey(const Key(KEY_SENHA_TEXT_FIELD)), '12345');
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));

      var senha = find
          .byKey(const Key(KEY_SENHA_TEXT_FIELD))
          .evaluate()
          .single
          .widget as TextField;
      expect(senha.controller!.text, equals("12345"));

      await tester.tap(find.byKey(const Key(KEY_OK_SENHA_BUTTON)));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));

      verify(() => senhaCubit.checkPassword("12345")).called(1);
      expect(senhaCubit.state, FailSenhaStates());

      await Future.delayed(const Duration(seconds: 5));
    });
  });

  group('Test WidgetConfig', () {
    testWidgets("Verificação de Retorno com sucesso", (tester) async {
      final configWebServiceModelInput = ConfigWebServiceModelInput(
        idBD: '1',
      );
      final config = Config(
        nroAparelhoConfig: 16997417840,
        passwordConfig: "12345",
        version: "1.0",
      );
      final data =
      ConfigWebServiceModelOutput.toConfigWebServiceModel(config).toJson();
      SharedPreferences.setMockInitialValues({});
      final dio = MockDio();
      await getIt.unregister<Dio>();
      getIt.registerSingleton<Dio>(dio);
      when(() => dio.post(BASE_URL + WEB_SAVE_TOKEN, data: data)).thenAnswer(
              (_) async => Response(
              data: jsonDecode(configWebServiceModelInput.toJson()),
              requestOptions: RequestOptions(),
              statusCode: 200));

      await tester.runAsync(getIt.allReady);
      await tester.pumpWidget(const AppWidget(
        urlInitial: "/config",
      ));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 10));

      await tester.enterText(
          find.byKey(const Key(KEY_NRO_APARELHO_CONFIG_TEXT_FIELD)),
          '16997417840');
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key(KEY_SENHA_CONFIG_TEXT_FIELD)), '12345');
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 10));

      await tester.tap(find.byKey(const Key(KEY_OK_CONFIG_BUTTON)));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 20));
    });
  });
}
