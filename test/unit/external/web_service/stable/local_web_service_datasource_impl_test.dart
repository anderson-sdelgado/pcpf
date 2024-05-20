import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/external/web_service/stable/local_web_service_datasource_impl.dart';
import 'package:pcp/infra/model/web_service/stable/local_web_service_model.dart';
import 'package:pcp/utils/constant.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  final List<LocalWebServiceModelInput> resultList = [
    LocalWebServiceModelInput(
      idLocal: 1,
      descrLocal: "Usina",
    ),
  ];
  const accessToken = "123456";

  group('Test LocalWebServiceDatasourceImpl', () {
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
        BASE_URL + WEB_ALL_LOCAL,
        (request) {
          return request.reply(200, jsonDecode(listLocal));
        },
        headers: headers,
      );
      final localWebServiceDatasourceImpl = LocalWebServiceDatasourceImpl(dio);
      final result =
          await localWebServiceDatasourceImpl.getAllLocal(accessToken);
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
            BASE_URL + WEB_ALL_LOCAL,
                (request) {
              return request.reply(200, jsonDecode(listLocalError));
            },
            headers: headers,
          );
          final localWebServiceDatasourceImpl = LocalWebServiceDatasourceImpl(dio);
          expect(
                () async =>
            await localWebServiceDatasourceImpl.getAllLocal(accessToken),
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
        BASE_URL + WEB_ALL_LOCAL,
        (server) => server.throws(
          404,
          DioException(
              requestOptions: RequestOptions(
            data: {'error', 'Teste'},
          )),
        ),
        headers: headers,
      );
      final localWebServiceDatasourceImpl = LocalWebServiceDatasourceImpl(dio);
      expect(
          () async =>
              await localWebServiceDatasourceImpl.getAllLocal(accessToken),
          throwsA(isA<ErrorWebServiceDatasource>()));
    });
  });
}

String listLocal = """[
  {
    "idLocal": 1,
    "descrLocal": "Usina"
  }
]""";

String listLocalError = """[
  {
    "idLocal": 1
  }
]""";

