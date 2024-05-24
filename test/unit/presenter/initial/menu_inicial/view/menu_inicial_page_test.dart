import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/app_widget.dart';
import 'package:pcp/presenter/initial/matric_vigia/view/matric_vigia_page.dart';
import 'package:pcp/presenter/initial/menu_inicial/cubit/menu_inicial_cubit.dart';
import 'package:pcp/presenter/initial/menu_inicial/cubit/menu_inicial_states.dart';
import 'package:pcp/presenter/initial/menu_inicial/view/menu_inicial_form.dart';

class MockMenuInicialCubit extends MockCubit<MenuInicialStates>
    implements MenuInicialCubit {}

class MockMenuInicialStates extends Fake implements MenuInicialStates {}

main() {
  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    setup();
  });

  group('Test MenuInicialPage', () {
    testWidgets('Verificar itens Menu Inicial', (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      await tester.pumpWidget(const AppWidget());
      await tester.pumpAndSettle();

      expect(find.text('APONTAMENTO'), findsOneWidget);
      expect(find.text('CONFIGURAÇÃO'), findsOneWidget);
      expect(find.text('SAIR'), findsOneWidget);
    });

    testWidgets("Checar State Initial do Menu Inicial",
        (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      registerFallbackValue(MockMenuInicialStates());
      MenuInicialCubit menuInicialCubit = MockMenuInicialCubit();
      await getIt.unregister<MenuInicialCubit>();
      getIt.registerFactory<MenuInicialCubit>(() => menuInicialCubit);
      when(() => menuInicialCubit.state).thenReturn(InitialMenuInicialStates());
      await tester.pumpWidget(const AppWidget());
      await tester.pumpAndSettle();
      expect(menuInicialCubit.state, InitialMenuInicialStates());
    });

    testWidgets("Verificar clique no item APONTAMENTO retornar falha'",
        (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      registerFallbackValue(MockMenuInicialStates());
      MenuInicialCubit menuInicialCubit = MockMenuInicialCubit();
      await getIt.unregister<MenuInicialCubit>();
      getIt.registerFactory<MenuInicialCubit>(() => menuInicialCubit);
      when(() => menuInicialCubit.state).thenReturn(InitialMenuInicialStates());
      when(() => menuInicialCubit.checkAccessApont()).thenAnswer((_) async {
        when(() => menuInicialCubit.state)
            .thenReturn(AccessDeniedMenuInicialStates());
      });

      await tester.pumpWidget(const AppWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key(KEY_APONT_MENU_INICIAL_ITEM)));
      await tester.pumpAndSettle();

      verify(() => menuInicialCubit.checkAccessApont()).called(1);
      expect(menuInicialCubit.state, AccessDeniedMenuInicialStates());
    });

    testWidgets(
        "Verificar clique no item APONTAMENTO retornar msg depois que gera falha'",
        (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      registerFallbackValue(MockMenuInicialStates());
      MenuInicialCubit menuInicialCubit = MockMenuInicialCubit();
      await getIt.unregister<MenuInicialCubit>();
      getIt.registerFactory<MenuInicialCubit>(() => menuInicialCubit);
      when(() => menuInicialCubit.state).thenReturn(InitialMenuInicialStates());

      whenListen(
          menuInicialCubit,
          Stream.fromIterable([
            InitialMenuInicialStates(),
            AccessDeniedMenuInicialStates(),
          ]));

      await tester.pumpWidget(const AppWidget());
      await tester.pumpAndSettle();

      expect(find.text("ATENÇÃO"), findsOneWidget);
      expect(
          find.text(
              "POR FAVOR, CONFIGURE O APLICATIVO ANTES DE COMEÇAR O APONTAMENTO!"),
          findsOneWidget);
    });

    testWidgets("Verificar clique no item APONTAMENTO retornar sucesso'",
        (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      registerFallbackValue(MockMenuInicialStates());
      MenuInicialCubit menuInicialCubit = MockMenuInicialCubit();
      await getIt.unregister<MenuInicialCubit>();
      getIt.registerFactory<MenuInicialCubit>(() => menuInicialCubit);
      when(() => menuInicialCubit.state).thenReturn(InitialMenuInicialStates());
      when(() => menuInicialCubit.checkAccessApont()).thenAnswer((_) async {
        when(() => menuInicialCubit.state)
            .thenReturn(AccessGrantedMenuInicialStates());
      });

      await tester.pumpWidget(const AppWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key(KEY_APONT_MENU_INICIAL_ITEM)));
      await tester.pumpAndSettle();

      verify(() => menuInicialCubit.checkAccessApont()).called(1);
      expect(menuInicialCubit.state, AccessGrantedMenuInicialStates());
    });


    testWidgets("Verificar clique no item APONTAMENTO ir pra outra tela se retornar sucesso'",
            (WidgetTester tester) async {
          await tester.runAsync(getIt.allReady);
          registerFallbackValue(MockMenuInicialStates());
          MenuInicialCubit menuInicialCubit = MockMenuInicialCubit();
          await getIt.unregister<MenuInicialCubit>();
          getIt.registerFactory<MenuInicialCubit>(() => menuInicialCubit);
          when(() => menuInicialCubit.state).thenReturn(InitialMenuInicialStates());

          whenListen(
              menuInicialCubit,
              Stream.fromIterable([
                InitialMenuInicialStates(),
                AccessGrantedMenuInicialStates(),
              ]));

          await tester.pumpWidget(const AppWidget());
          await tester.pumpAndSettle();

          expect(find.byType(MatricVigiaPage), findsOneWidget);
        });
  });

}
