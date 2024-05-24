import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/app_widget.dart';
import 'package:pcp/domain/entities/variable/config.dart';
import 'package:pcp/infra/model/shared_preferences/config_shared_preferences_model.dart';
import 'package:pcp/presenter/initial/matric_vigia/view/matric_vigia_page.dart';
import 'package:pcp/presenter/initial/menu_inicial/view/menu_inicial_form.dart';
import 'package:pcp/utils/constant.dart';
import 'package:pcp/utils/enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    setup();
  });

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Fluxo completo', () {});

  group('Test WidgetInicial', () {
    testWidgets(
        'Verificar ao clique no item APONTAMENTO gera msg porque esta sem nenhuma configuração',
        (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      await tester.pumpWidget(const AppWidget());
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(find.byKey(const Key(KEY_APONT_MENU_INICIAL_ITEM)));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      expect(find.text("ATENÇÃO"), findsOneWidget);
      expect(
          find.text(
              "POR FAVOR, CONFIGURE O APLICATIVO ANTES DE COMEÇAR O APONTAMENTO!"),
          findsOneWidget);
      await Future.delayed(const Duration(seconds: 2));
    });

    testWidgets(
        'Verificar ao clique no item APONTAMENTO gera msg porque esta configurado mas não esta completamente atualizado',
        (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      final config = Config(
        nroAparelhoConfig: 16997417840,
        passwordConfig: "12345",
        version: "1.00",
        idBDConfig: 1,
        flagUpdate: FlagUpdate.OUTDATED,
      );
      final configModel =
          ConfigSharedPreferencesModel.toConfigSharedPreferencesModel(config)
              .toJson();
      SharedPreferences.setMockInitialValues(
          {BASE_SHARE_PREFERENCES_TABLE_CONFIG: configModel});
      await tester.pumpWidget(const AppWidget());
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(find.byKey(const Key(KEY_APONT_MENU_INICIAL_ITEM)));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      expect(find.text("ATENÇÃO"), findsOneWidget);
      expect(
          find.text(
              "POR FAVOR, CONFIGURE O APLICATIVO ANTES DE COMEÇAR O APONTAMENTO!"),
          findsOneWidget);
      await Future.delayed(const Duration(seconds: 2));
    });

    testWidgets(
        'Verificar ao clique no item APONTAMENTO ir para tela de matric de Vigia quando o aplicativo estiver completamente atualizado',
        (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      final config = Config(
        nroAparelhoConfig: 16997417840,
        passwordConfig: "12345",
        version: "1.00",
        idBDConfig: 1,
        flagUpdate: FlagUpdate.UPDATED,
      );
      final configModel =
          ConfigSharedPreferencesModel.toConfigSharedPreferencesModel(config)
              .toJson();
      SharedPreferences.setMockInitialValues(
          {BASE_SHARE_PREFERENCES_TABLE_CONFIG: configModel});
      await tester.pumpWidget(const AppWidget());
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(find.byKey(const Key(KEY_APONT_MENU_INICIAL_ITEM)));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      expect(find.byType(MatricVigiaPage), findsOneWidget);
      await Future.delayed(const Duration(seconds: 2));
    });
  });

  group('Test WidgetMenuMatric', () {
    testWidgets("Abrir tela de Matric de Vigia", (WidgetTester tester) async {
      await tester.runAsync(getIt.allReady);
      await tester.pumpWidget(const AppWidget(
        urlInitial: "/matricvigia",
      ));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      expect(find.byType(MatricVigiaPage), findsOneWidget);
      await Future.delayed(const Duration(seconds: 20));
    });
  });
}
