import 'package:pcp/infra/model/web_service/stable/visitante_web_service_model.dart';

abstract class VisitanteWebServiceDatasource {
  Future<List<VisitanteWebServiceModelInput>> getAllVisitante(String token);
}