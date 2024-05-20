import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/entities/variable/config.dart';
import 'package:pcp/domain/usecases/initial/send_initial_config.dart';
import 'package:pcp/infra/model/web_service/variable/config_web_service_model.dart';
import 'package:pcp/utils/constant.dart';

import '../../../utils/mock_dio.mocks.dart';

main() {
  group('Test SendInitialConfig', () {
    test('deve retornar o Id do Web service com conexão', () async {
      WidgetsFlutterBinding.ensureInitialized();
      setup();
      final sendInitialConfig = getIt<SendInitialConfig>();
      var result = await sendInitialConfig(
        nroAparelho: "16997417840",
        version: "1.00",
        senha: "12345",
      );
      expect(result.isRight(), true);
    });
  });
}
