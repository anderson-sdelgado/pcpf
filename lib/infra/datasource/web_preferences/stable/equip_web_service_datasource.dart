import 'package:pcp/infra/model/web_service/stable/equip_web_service_model.dart';

abstract class EquipWebServiceDatasource {
  Future<List<EquipWebServiceModelInput>> getAllEquip(String token);
}