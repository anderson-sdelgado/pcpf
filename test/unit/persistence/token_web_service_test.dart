import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/infra/model/web_service/variable/config_web_service_model.dart';
import 'package:pcp/utils/constant.dart';

final dio = Dio();

void main() async {
  test('deve retornar Id da base de dados Conectando', () async {
    final configWebServiceModelOutput = ConfigWebServiceModelOutput(
      nroAparelho: 16997417840,
      version: "1.0",
    );
    final configWebServiceModelInput = ConfigWebServiceModelInput(
      idBD: '2',
    );
    final response = await dio.post(BASE_URL + WEB_SAVE_TOKEN, data: configWebServiceModelOutput.toJson());
    expect(ConfigWebServiceModelInput.fromMap(response.data), configWebServiceModelInput);
  });
}