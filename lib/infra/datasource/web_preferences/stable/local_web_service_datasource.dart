import 'package:pcp/infra/model/web_service/stable/local_web_service_model.dart';

abstract class LocalWebServiceDatasource {
  Future<List<LocalWebServiceModelInput>> getAllLocal(String token);
}