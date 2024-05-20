import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/external/web_service/variable/config_web_service_datasource_impl.dart';
import 'package:pcp/infra/model/web_service/variable/config_web_service_model.dart';
import 'package:pcp/utils/constant.dart';

import '../../../../utils/mock_dio.mocks.dart';

main() {
  final dio = MockDio();
  final configWebServiceDatasourceImpl = ConfigWebServiceDatasourceImpl(dio);

  group('Test ConfigWebServiceDatasourceImpl', () {
    test('deve retornar Id da base de dados', () async {
      final configWebServiceModelOutput = ConfigWebServiceModelOutput(
        nroAparelho: 16997417840,
        version: "1.0",
      );
      final configWebServiceModelInput = ConfigWebServiceModelInput(
        idBD: '1',
      );
      when(dio.post(BASE_URL + WEB_SAVE_TOKEN,
              data: configWebServiceModelOutput.toJson()))
          .thenAnswer((_) async => Response(
              data: jsonDecode(configWebServiceModelInput.toJson()), requestOptions: RequestOptions(), statusCode: 200));
      final result = await configWebServiceDatasourceImpl
          .sendConfig(configWebServiceModelOutput);
      expect(result, configWebServiceModelInput);
    });

    test('deve retornar falha quando o codigo for 404', () async {
      final configWebServiceModelOutput = ConfigWebServiceModelOutput(
        nroAparelho: 16997417840,
        version: "1.0",
      );
      final configWebServiceModelInput = ConfigWebServiceModelInput(
        idBD: '1',
      );
      when(dio.post(BASE_URL + WEB_SAVE_TOKEN,
          data: configWebServiceModelOutput.toJson()))
          .thenAnswer((_) async => Response(
          data: jsonDecode(configWebServiceModelInput.toJson()), requestOptions: RequestOptions(), statusCode: 404));
      expect(() async => await configWebServiceDatasourceImpl
          .sendConfig(configWebServiceModelOutput), throwsA(isA<ErrorWebServiceDatasource>()));
    });
  });
}
