import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/main.dart' as app;
import 'package:pcp/presenter/initial/menu_inicial/menu_inicial_page.dart';
import 'package:pcp/presenter/initial/senha/senha_cubit.dart';
import 'package:pcp/presenter/initial/senha/senha_page.dart';
import 'package:pcp/presenter/initial/senha/senha_states.dart';

class MockSenhaCubit extends MockCubit<SenhaStates> implements SenhaCubit {}

class MockSenhaStates extends Fake implements SenhaStates {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // testWidgets('Teste de Acesso ao aplicativo', (WidgetTester tester) async {
  //   app.main();
  //   await tester.pumpAndSettle();
  //   await Future.delayed(const Duration(seconds: 2));
  //   await tester.tap(find.byKey(const Key(KEY_CONFIG_MENU_INICIAL_ITEM)));
  //   await tester.pumpAndSettle();
  //   await Future.delayed(const Duration(seconds: 2));
  //   expect(find.text('CANCELAR'), findsOneWidget);
  // });
  //
  // testWidgets('Teste de Acesso Configurações', (WidgetTester tester) async {
  //   app.main();
  //   await tester.pumpAndSettle();
  //   await Future.delayed(const Duration(seconds: 2));
  //   await tester.tap(find.byKey(const Key(KEY_CONFIG_MENU_INICIAL_ITEM)));
  //   await tester.pumpAndSettle();
  //   await Future.delayed(const Duration(seconds: 2));
  //   await tester.tap(find.byKey(const Key(KEY_OK_SENHA_BUTTON)));
  //   await tester.pumpAndSettle();
  //   await Future.delayed(const Duration(seconds: 2));
  //   expect(find.text('CONFIGURAÇÕES'), findsOneWidget);
  // });

  testWidgets('Teste de Acesso Configurações', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    await tester.tap(find.byKey(const Key(KEY_CONFIG_MENU_INICIAL_ITEM)));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));

    registerFallbackValue(MockSenhaStates());
    var senhaCubit = MockSenhaCubit();
    // when(() => senhaCubit.state).thenReturn(InitialSenhaStates());
    when(() => senhaCubit.checkPassword("12345")).thenAnswer((_) async {
      when(() => senhaCubit.state).thenReturn(FailSenhaStates());
    });
    Modular.bindModule(AppModule());
    Modular.replaceInstance<SenhaCubit>(senhaCubit);

    await tester.enterText(
        find.byKey(const Key(KEY_SENHA_TEXT_FIELD)), '12345');
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));

    await tester.tap(find.byKey(const Key(KEY_OK_SENHA_BUTTON)));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    expect(find.text('CONFIGURAÇÕES'), findsOneWidget);


  });

}