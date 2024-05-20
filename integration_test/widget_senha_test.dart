import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/app_widget.dart';
import 'package:pcp/presenter/initial/senha/cubit/senha_cubit.dart';
import 'package:pcp/presenter/initial/senha/cubit/senha_states.dart';
import 'package:pcp/presenter/initial/senha/view/senha_form.dart';

class MockSenhaCubit extends MockCubit<SenhaStates> implements SenhaCubit {}

class MockSenhaStates extends Fake implements SenhaStates {}

void main() async {
  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    setup();
  });

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

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
    await Future.delayed(const Duration(seconds: 2));

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
}
