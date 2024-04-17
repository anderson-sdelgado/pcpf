import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/app_widget.dart';
import 'package:pcp/domain/usecases/initial/check_password_config.dart';
import 'package:pcp/presenter/initial/senha/senha_cubit.dart';
import 'package:pcp/presenter/initial/senha/senha_page.dart';
import 'package:pcp/presenter/initial/senha/senha_states.dart';

class MockSenhaCubit extends MockCubit<SenhaStates> implements SenhaCubit {}

class MockSenhaStates extends Fake implements SenhaStates {}

class ModularNavigateMock extends Mock implements IModularNavigator {}

main() {
  group('Test SenhaPage', () {
    final modularApp = ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    );
    Modular.setInitialRoute('/senha');

    testWidgets("Verificar retorno no clique do button Cancelar",
        (WidgetTester tester) async {
      await tester.pumpWidget(modularApp);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key(KEY_CANCELAR_SENHA_BUTTON)), findsOneWidget);
      await tester.tap(find.byKey(const Key(KEY_CANCELAR_SENHA_BUTTON)));
      await tester.pumpAndSettle();

      expect(find.text('APONTAMENTO'), findsOneWidget);
      expect(find.text('CONFIGURAÇÃO'), findsOneWidget);
      expect(find.text('SAIR'), findsOneWidget);
    });

    testWidgets("Verificar tela de Senha", (WidgetTester tester) async {
      await tester.pumpWidget(modularApp);
      await tester.pumpAndSettle();

      expect(find.text('CANCELAR'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets("Verificar senha digitada", (WidgetTester tester) async {
      await tester.pumpWidget(modularApp);
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byKey(const Key(KEY_SENHA_TEXT_FIELD)), '12345');
      await tester.pumpAndSettle();

      var senha = find
          .byKey(const Key(KEY_SENHA_TEXT_FIELD))
          .evaluate()
          .single
          .widget as TextField;
      expect(senha.controller!.text, equals("12345"));
    });

    testWidgets("Verificar senha digitada no campo",
        (WidgetTester tester) async {
      await tester.pumpWidget(modularApp);
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byKey(const Key(KEY_SENHA_TEXT_FIELD)), '12345');
      await tester.pumpAndSettle();

      var senha = find
          .byKey(const Key(KEY_SENHA_TEXT_FIELD))
          .evaluate()
          .single
          .widget as TextField;
      expect(senha.controller!.text, equals("12345"));
    });

    testWidgets("Verificar button chamou função CheckPassword do SenhaCubit", (WidgetTester tester) async {
      registerFallbackValue(MockSenhaStates());
      SenhaCubit senhaCubit = MockSenhaCubit();
      when(() => senhaCubit.state).thenReturn(InitialSenhaStates());
      when(() => senhaCubit.checkPassword("12345")).thenAnswer((_) async {
        when(() => senhaCubit.state).thenReturn(SuccessSenhaStates());
      });
      Modular.bindModule(AppModule());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: senhaCubit,
              child: const SenhaPageStful(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key(KEY_OK_SENHA_BUTTON)));
      await tester.pumpAndSettle();

      verify(() => senhaCubit.checkPassword("12345")).called(1);

    });

    testWidgets("Verificar retorno de SucessoSenha", (WidgetTester tester) async {
      registerFallbackValue(MockSenhaStates());
      SenhaCubit senhaCubit = MockSenhaCubit();
      final navigator = ModularNavigateMock();
      Modular.navigatorDelegate = navigator;
      when(() => navigator.navigate("/config")).thenAnswer((_) => Future.value());
      when(() => senhaCubit.state).thenReturn(InitialSenhaStates());

      whenListen(senhaCubit, Stream.fromIterable([
        InitialSenhaStates(),
        SuccessSenhaStates(),
      ]));

      Modular.bindModule(AppModule());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: senhaCubit,
              child: const SenhaPageStful(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      verify(() => navigator.navigate("/config")).called(1);

    });

    testWidgets("Verificar retorno de Falha de Senha", (WidgetTester tester) async {
      registerFallbackValue(MockSenhaStates());
      SenhaCubit senhaCubit = MockSenhaCubit();
      final navigator = ModularNavigateMock();
      Modular.navigatorDelegate = navigator;
      when(() => navigator.navigate("/config")).thenAnswer((_) => Future.value());
      when(() => senhaCubit.state).thenReturn(InitialSenhaStates());

      whenListen(senhaCubit, Stream.fromIterable([
        InitialSenhaStates(),
        FailSenhaStates(),
      ]));

      Modular.bindModule(AppModule());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: senhaCubit,
              child: const SenhaPageStful(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text("ATENÇÃO"), findsOneWidget);
      expect(find.text("SENHA INVÁLIDA!"), findsOneWidget);

    });
  });
}
