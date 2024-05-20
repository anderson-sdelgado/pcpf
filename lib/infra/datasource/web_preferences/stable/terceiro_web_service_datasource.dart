import 'package:pcp/infra/model/web_service/stable/terceiro_web_service_model.dart';

abstract class TerceiroWebServiceDatasource {
  Future<List<TerceiroWebServiceModelInput>> getAllTerceiro(String token);
}