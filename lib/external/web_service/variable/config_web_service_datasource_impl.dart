import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/infra/datasource/web_preferences/variable/config_web_service_datasource.dart';
import 'package:pcp/infra/model/web_service/variable/config_web_service_model.dart';
import 'package:dio/dio.dart';
import 'package:pcp/utils/constant.dart';

class ConfigWebServiceDatasourceImpl implements ConfigWebServiceDatasource {
  final Dio dio;

  ConfigWebServiceDatasourceImpl(this.dio);

  @override
  Future<ConfigWebServiceModelInput> sendConfig(
      ConfigWebServiceModelOutput configWebServiceModelOutput) async {
    try {
      final response = await dio.post(
        BASE_URL + WEB_SAVE_TOKEN,
        data: configWebServiceModelOutput.toJson(),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        return ConfigWebServiceModelInput.fromMap(data);
      } else {
        throw ErrorWebServiceDatasource("sendConfig => Connect Failed");
      }
    } catch (e) {
      throw ErrorWebServiceDatasource("sendConfig => ${e.toString()}");
    }
  }
}
