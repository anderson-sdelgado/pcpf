import 'package:pcp/infra/model/web_service/variable/config_web_service_model.dart';

abstract class ConfigWebServiceDatasource {
  Future<ConfigWebServiceModelInput> sendConfig(ConfigWebServiceModelOutput configWebServiceModelOutput);
}