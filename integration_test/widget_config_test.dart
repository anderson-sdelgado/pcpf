import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/app_widget.dart';
import 'package:pcp/domain/entities/variable/config.dart';
import 'package:pcp/domain/repositories/variable/config_repository.dart';
import 'package:pcp/infra/model/web_service/variable/config_web_service_model.dart';
import 'package:pcp/presenter/initial/config/view/config_form.dart';
import 'package:pcp/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../test/utils/mock_dio.mocks.dart';

void main() async {
  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    setup();
  });

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final configWebServiceModelInput = ConfigWebServiceModelInput(
    idBD: '1',
  );
  final config = Config(
    nroAparelhoConfig: 16997417840,
    passwordConfig: "12345",
    version: "1.0",
  );
  final _data =
      ConfigWebServiceModelOutput.toConfigWebServiceModel(config).toJson();

  testWidgets("Verificação de Retorno com sucesso", (tester) async {
    await tester.runAsync(getIt.allReady);
    SharedPreferences.setMockInitialValues({});
    final dio = MockDio();
    await getIt.unregister<Dio>();
    getIt.registerSingleton<Dio>(dio);
    when(dio.post(BASE_URL + WEB_SAVE_TOKEN, data: _data)).thenAnswer(
        (_) async => Response(
            data: jsonDecode(configWebServiceModelInput.toJson()),
            requestOptions: RequestOptions(),
            statusCode: 200));

    await tester.pumpWidget(const AppWidget(
      urlInitial: "/config",
    ));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));

    await tester.enterText(
        find.byKey(const Key(KEY_NRO_APARELHO_CONFIG_TEXT_FIELD)),
        '16997417840');
    await tester.pumpAndSettle();
    await tester.enterText(
        find.byKey(const Key(KEY_SENHA_CONFIG_TEXT_FIELD)), '12345');
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));

    await tester.tap(find.byKey(const Key(KEY_OK_CONFIG_BUTTON)));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 10));
  });
}
