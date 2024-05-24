import 'package:dio/dio.dart';
import 'package:pcp/utils/constant.dart';
import 'package:test/test.dart';

void main() async {
  group('Test Dio', () {
    final headers = <String, dynamic>{
      'Authorization': 'Bearer DDEEC1BDE4F4FFA037A8110E84A81F06',
    };

    test('test Dio Colab', () async {
      final dio = Dio();
      final response = await dio.get(
        BASE_URL + WEB_ALL_COLAB,
        options: Options(
          headers: headers,
        ),
      );
      expect(response.statusCode, 200);
    });

    test('test Dio Equip', () async {
      final dio = Dio();
      final response = await dio.get(
        BASE_URL + WEB_ALL_EQUIP,
        options: Options(
          headers: headers,
        ),
      );
      expect(response.statusCode, 200);
    });

    test('test Dio Local', () async {
      final dio = Dio();
      final response = await dio.get(
        BASE_URL + WEB_ALL_LOCAL,
        options: Options(
          headers: headers,
        ),
      );
      expect(response.statusCode, 200);
    });

    test('test Dio Terceiro', () async {
      final dio = Dio();
      final response = await dio.get(
        BASE_URL + WEB_ALL_TERCEIRO,
        options: Options(
          headers: headers,
        ),
      );
      expect(response.statusCode, 200);
    });

    test('test Dio Terceiro', () async {
      final dio = Dio();
      final response = await dio.get(
        BASE_URL + WEB_ALL_TERCEIRO,
        options: Options(
          headers: headers,
        ),
      );
      expect(response.statusCode, 200);
    });

    test('test Dio Visitante', () async {
      final dio = Dio();
      final response = await dio.get(
        BASE_URL + WEB_ALL_VISITANTE,
        options: Options(
          headers: headers,
        ),
      );
      expect(response.statusCode, 200);
    });
  });
}
