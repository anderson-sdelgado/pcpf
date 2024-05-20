import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/external/web_service/stable/visitante_web_service_datasource_impl.dart';
import 'package:pcp/infra/model/web_service/stable/visitante_web_service_model.dart';
import 'package:pcp/utils/constant.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  final List<VisitanteWebServiceModelInput> resultList = [
    VisitanteWebServiceModelInput(
      idVisitante: 1,
      cpfVisitante: "123.456.789-00",
      nomeVisitante: "Teste",
      empresaVisitante: "Visitante Empresa",
    ),
  ];
  const accessToken = "123456";

  group('Test VisitanteWebServiceDatasourceImpl', () {
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
        BASE_URL + WEB_ALL_VISITANTE,
        (request) {
          return request.reply(200, jsonDecode(listVisitante));
        },
        headers: headers,
      );
      final visitanteWebServiceDatasourceImpl = VisitanteWebServiceDatasourceImpl(dio);
      final result =
          await visitanteWebServiceDatasourceImpl.getAllVisitante(accessToken);
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
            BASE_URL + WEB_ALL_VISITANTE,
                (request) {
              return request.reply(200, jsonDecode(listVisitanteError));
            },
            headers: headers,
          );
          final visitanteWebServiceDatasourceImpl = VisitanteWebServiceDatasourceImpl(dio);
          expect(
                () async =>
            await visitanteWebServiceDatasourceImpl.getAllVisitante(accessToken),
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
        BASE_URL + WEB_ALL_VISITANTE,
        (server) => server.throws(
          404,
          DioException(
              requestOptions: RequestOptions(
            data: {'error', 'Teste'},
          )),
        ),
        headers: headers,
      );
      final visitanteWebServiceDatasourceImpl = VisitanteWebServiceDatasourceImpl(dio);
      expect(
          () async =>
              await visitanteWebServiceDatasourceImpl.getAllVisitante(accessToken),
          throwsA(isA<ErrorWebServiceDatasource>()));
    });
  });
}

String listVisitante = """[
  {
    "idVisitante": 1,
    "cpfVisitante": "123.456.789-00",
    "nomeVisitante": "Teste",
    "empresaVisitante": "Visitante Empresa"
  }
]""";

String listVisitanteError = """[
  {
    "idVisitante": 1,
    "cpfVisitante": "123.456.789-00",
    "empresaVisitante": "Visitante Empresa"
  }
]""";

