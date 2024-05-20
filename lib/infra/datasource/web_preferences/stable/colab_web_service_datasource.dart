import 'package:pcp/infra/model/web_service/stable/colab_web_service_model.dart';

abstract class ColabWebServiceDatasource {
  Future<List<ColabWebServiceModelInput>> getAllColab(String token);
}