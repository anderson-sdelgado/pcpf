import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/app_widget.dart';
import 'package:pcp/presenter/initial/menu_inicial/menu_inicial_page.dart';
import 'package:pcp/presenter/initial/senha/senha_cubit.dart';
import 'package:pcp/presenter/initial/senha/senha_page.dart';
import 'package:pcp/presenter/initial/senha/senha_states.dart';

import '../../../../utils/app_fake.dart';

class MockSenhaCubit extends MockCubit<SenhaStates> implements SenhaCubit {}

class MockSenhaStates extends Fake implements SenhaStates {}

main() {
  group('Test MenuInicialPage', () {
    testWidgets('Verificar itens Menu Inicial', (WidgetTester tester) async {
      final modularApp = ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      );
      await tester.pumpWidget(modularApp);
      await tester.pumpAndSettle();

      expect(find.text('APONTAMENTO'), findsOneWidget);
      expect(find.text('CONFIGURAÇÃO'), findsOneWidget);
      expect(find.text('SAIR'), findsOneWidget);
    });

    testWidgets('Verificar clique no item CONFIGURAÇÃO',
        (WidgetTester tester) async {
      final modularApp = ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      );
      await tester.pumpWidget(modularApp);
      await tester.pumpAndSettle();

      expect(find.text('APONTAMENTO'), findsOneWidget);
      expect(find.text('CONFIGURAÇÃO'), findsOneWidget);
      expect(find.text('SAIR'), findsOneWidget);

      expect(
          find.byKey(const Key(KEY_CONFIG_MENU_INICIAL_ITEM)), findsOneWidget);
      await tester.tap(find.byKey(const Key(KEY_CONFIG_MENU_INICIAL_ITEM)));
      await tester.pumpAndSettle();

      expect(find.byType(SenhaPage) ,findsOneWidget);

    });

  });
}
