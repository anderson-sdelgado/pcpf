import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/app_widget.dart';
import 'package:pcp/presenter/initial/config/view/config_page.dart';
import 'package:pcp/presenter/initial/menu_inicial/menu_inicial_page.dart';
import 'package:pcp/presenter/initial/senha/cubit/senha_cubit.dart';
import 'package:pcp/presenter/initial/senha/cubit/senha_states.dart';
import 'package:pcp/presenter/initial/senha/view/senha_form.dart';

class MockSenhaCubit extends MockCubit<SenhaStates> implements SenhaCubit {}

class MockSenhaStates extends Fake implements SenhaStates {}

main() {
  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    setup();
  });

  group('Test SenhaPage', () {
    testWidgets("Verificar tela de Senha", (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      await tester.pumpWidget(const AppWidget(
        urlInitial: "/senha",
      ));
      await tester.pumpAndSettle();

      expect(find.text('CANCELAR'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets("Verificar senha digitada", (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      await tester.pumpWidget(const AppWidget(
        urlInitial: "/senha",
      ));
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
      await tester.runAsync(getIt.allReady);
      await tester.pumpWidget(const AppWidget(
        urlInitial: "/senha",
      ));
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

    testWidgets("Checar State Initial do SenhaCubit",
        (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      registerFallbackValue(MockSenhaStates());
      SenhaCubit senhaCubit = MockSenhaCubit();
      await getIt.unregister<SenhaCubit>();
      getIt.registerFactory<SenhaCubit>(() => senhaCubit);
      when(() => senhaCubit.state).thenReturn(InitialSenhaStates());
      await tester.pumpWidget(const AppWidget(
        urlInitial: "/senha",
      ));
      await tester.pumpAndSettle();
      expect(senhaCubit.state, InitialSenhaStates());
    });

    testWidgets("Verificar senha digitada no campo e butão clicado",
        (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      registerFallbackValue(MockSenhaStates());
      SenhaCubit senhaCubit = MockSenhaCubit();
      await getIt.unregister<SenhaCubit>();
      getIt.registerFactory<SenhaCubit>(() => senhaCubit);
      when(() => senhaCubit.state).thenReturn(InitialSenhaStates());
      when(() => senhaCubit.checkPassword("12345")).thenAnswer((_) async {
        when(() => senhaCubit.state).thenReturn(SuccessSenhaStates());
      });

      await tester.pumpWidget(const AppWidget(
        urlInitial: "/senha",
      ));
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

      await tester.tap(find.byKey(const Key(KEY_OK_SENHA_BUTTON)));
      await tester.pumpAndSettle();

      verify(() => senhaCubit.checkPassword("12345")).called(1);
      expect(senhaCubit.state, SuccessSenhaStates());
    });

    testWidgets("Verificar retorno de SucessoSenha",
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
            SuccessSenhaStates(),
          ]));

      await tester.pumpWidget(const AppWidget(
        urlInitial: "/senha",
      ));
      await tester.pumpAndSettle();

      expect(find.byType(ConfigPage), findsOneWidget);
    });

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

      await tester.enterText(
          find.byKey(const Key(KEY_SENHA_TEXT_FIELD)), '12345');
      await tester.pumpAndSettle();

      var senha = find
          .byKey(const Key(KEY_SENHA_TEXT_FIELD))
          .evaluate()
          .single
          .widget as TextField;
      expect(senha.controller!.text, equals("12345"));

      await tester.tap(find.byKey(const Key(KEY_OK_SENHA_BUTTON)));
      await tester.pumpAndSettle();

      verify(() => senhaCubit.checkPassword("12345")).called(1);
      expect(senhaCubit.state, FailSenhaStates());
    });

    testWidgets("Verificar retorno no clique do button Cancelar",
        (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      registerFallbackValue(MockSenhaStates());
      SenhaCubit senhaCubit = MockSenhaCubit();
      await getIt.unregister<SenhaCubit>();
      getIt.registerFactory<SenhaCubit>(() => senhaCubit);
      when(() => senhaCubit.state).thenReturn(InitialSenhaStates());

      await tester.pumpWidget(const AppWidget(
        urlInitial: "/senha",
      ));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key(KEY_CANCELAR_SENHA_BUTTON)), findsOneWidget);
      await tester.tap(find.byKey(const Key(KEY_CANCELAR_SENHA_BUTTON)));
      await tester.pumpAndSettle();

      expect(find.byType(MenuInicialPage), findsOneWidget);
    });
  });
}
