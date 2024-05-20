import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/external/web_service/stable/equip_web_service_datasource_impl.dart';
import 'package:pcp/infra/model/web_service/stable/equip_web_service_model.dart';
import 'package:pcp/utils/constant.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  final List<EquipWebServiceModelInput> resultList = [
    EquipWebServiceModelInput(
      idEquip: 1,
      nroEquip: 100,
    ),
  ];
  const accessToken = "123456";

  group('Test EquipWebServiceDatasourceImpl', () {
    test('deve retornar lista do Web Service', () async {
      final headers = <String, dynamic>{
        'Authorization': 'Bearer $accessToken',
      };
      dio = Dio();
      dioAdapter = DioAdapter(
        dio: dio,
        matcher: const FullHttpRequestMatcher(),
      );
      dioAdapter.onGet(
        BASE_URL + WEB_ALL_EQUIP,
        (request) {
          return request.reply(200, jsonDecode(listEquip));
        },
        headers: headers,
      );
      final equipWebServiceDatasourceImpl = EquipWebServiceDatasourceImpl(dio);
      final result =
          await equipWebServiceDatasourceImpl.getAllEquip(accessToken);
      expect(result, resultList);
    });

    test('deve retornar erro se a lista do Web Service estiver incorreta',
            () async {
          final headers = <String, dynamic>{
            'Authorization': 'Bearer $accessToken',
          };
          dio = Dio();
          dioAdapter = DioAdapter(
            dio: dio,
            matcher: const FullHttpRequestMatcher(),
          );
          dioAdapter.onGet(
            BASE_URL + WEB_ALL_EQUIP,
                (request) {
              return request.reply(200, jsonDecode(listEquipError));
            },
            headers: headers,
          );
          final equipWebServiceDatasourceImpl = EquipWebServiceDatasourceImpl(dio);
          expect(
                () async =>
            await equipWebServiceDatasourceImpl.getAllEquip(accessToken),
            throwsA(isA<ErrorWebServiceDatasource>()),
          );
        });

    test('deve retornar falha quando o codigo for 404', () async {
      final headers = <String, dynamic>{
        'Authorization': 'Bearer $accessToken',
      };
      dio = Dio();
      dioAdapter = DioAdapter(
        dio: dio,
        matcher: const FullHttpRequestMatcher(),
      );
      dioAdapter.onGet(
        BASE_URL + WEB_ALL_EQUIP,
        (server) => server.throws(
          404,
          DioException(
              requestOptions: RequestOptions(
            data: {'error', 'Teste'},
          )),
        ),
        headers: headers,
      );
      final equipWebServiceDatasourceImpl = EquipWebServiceDatasourceImpl(dio);
      expect(
          () async =>
              await equipWebServiceDatasourceImpl.getAllEquip(accessToken),
          throwsA(isA<ErrorWebServiceDatasource>()));
    });
  });
}

String listEquip = """[
  {
    "idEquip": 1,
    "nroEquip": 100
  }
]""";

String listEquipError = """[
  {
    "idEquip": 1
  }
]""";
