import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/external/web_service/stable/terceiro_web_service_datasource_impl.dart';
import 'package:pcp/infra/model/web_service/stable/terceiro_web_service_model.dart';
import 'package:pcp/utils/constant.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  final List<TerceiroWebServiceModelInput> resultList = [
    TerceiroWebServiceModelInput(
      idBDTerceiro: 1,
      cpfTerceiro: "123.456.789-00",
      nomeTerceiro: "Teste",
      empresaTerceiro: "Terceiro Empresa",
    ),
  ];
  const accessToken = "123456";

  group('Test TerceiroWebServiceDatasourceImpl', () {
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
        BASE_URL + WEB_ALL_TERCEIRO,
        (request) {
          return request.reply(200, jsonDecode(listTerceiro));
        },
        headers: headers,
      );
      final terceiroWebServiceDatasourceImpl = TerceiroWebServiceDatasourceImpl(dio);
      final result =
          await terceiroWebServiceDatasourceImpl.getAllTerceiro(accessToken);
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
            BASE_URL + WEB_ALL_TERCEIRO,
                (request) {
              return request.reply(200, jsonDecode(listTerceiroError));
            },
            headers: headers,
          );
          final terceiroWebServiceDatasourceImpl = TerceiroWebServiceDatasourceImpl(dio);
          expect(
                () async =>
            await terceiroWebServiceDatasourceImpl.getAllTerceiro(accessToken),
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
        BASE_URL + WEB_ALL_TERCEIRO,
        (server) => server.throws(
          404,
          DioException(
              requestOptions: RequestOptions(
            data: {'error', 'Teste'},
          )),
        ),
        headers: headers,
      );
      final terceiroWebServiceDatasourceImpl = TerceiroWebServiceDatasourceImpl(dio);
      expect(
          () async =>
              await terceiroWebServiceDatasourceImpl.getAllTerceiro(accessToken),
          throwsA(isA<ErrorWebServiceDatasource>()));
    });
  });
}

String listTerceiro = """[
  {
    "idBDTerceiro": 1,
    "cpfTerceiro": "123.456.789-00",
    "nomeTerceiro": "Teste",
    "empresaTerceiro": "Terceiro Empresa"
  }
]""";

String listTerceiroError = """[
  {
    "idBDTerceiro": 1,
    "cpfTerceiro": "123.456.789-00",
    "nomeTerceiro": "Teste"
  }
]""";
