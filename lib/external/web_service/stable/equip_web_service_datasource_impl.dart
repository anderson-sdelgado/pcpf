import 'package:dio/dio.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/infra/datasource/web_preferences/stable/equip_web_service_datasource.dart';
import 'package:pcp/infra/model/web_service/stable/equip_web_service_model.dart';
import 'package:pcp/utils/constant.dart';

class EquipWebServiceDatasourceImpl implements EquipWebServiceDatasource {
  final Dio dio;

  EquipWebServiceDatasourceImpl(this.dio);

  @override
  Future<List<EquipWebServiceModelInput>> getAllEquip(
      String accessToken) async {
    try {
      final headers = <String, dynamic>{
        'Authorization': 'Bearer $accessToken',
      };
      final response = await dio.get(
        BASE_URL + WEB_ALL_EQUIP,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        return (data as List)
            .map((e) => EquipWebServiceModelInput.fromMap(e))
            .toList();
      } else {
        throw ErrorWebServiceDatasource("sendConfig => Connect Failed");
      }
    } catch (e) {
      throw ErrorWebServiceDatasource("sendConfig => ${e.toString()}");
    }
  }
}
