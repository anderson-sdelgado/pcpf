import 'package:mockito/annotations.dart';
import 'package:pcp/infra/datasource/floor/stable/colab_floor_datasource.dart';
import 'package:pcp/infra/datasource/floor/stable/equip_floor_datasource.dart';
import 'package:pcp/infra/datasource/floor/stable/local_floor_datasource.dart';
import 'package:pcp/infra/datasource/floor/stable/terceiro_floor_datasource.dart';
import 'package:pcp/infra/datasource/floor/stable/visitante_floor_datasource.dart';
import 'package:pcp/infra/datasource/shared_preferences/config_shared_preferences_datasource.dart';
import 'package:pcp/infra/datasource/web_preferences/stable/colab_web_service_datasource.dart';
import 'package:pcp/infra/datasource/web_preferences/stable/equip_web_service_datasource.dart';
import 'package:pcp/infra/datasource/web_preferences/stable/local_web_service_datasource.dart';
import 'package:pcp/infra/datasource/web_preferences/stable/terceiro_web_service_datasource.dart';
import 'package:pcp/infra/datasource/web_preferences/stable/visitante_web_service_datasource.dart';
import 'package:pcp/infra/datasource/web_preferences/variable/config_web_service_datasource.dart';

@GenerateMocks([
  ConfigSharedPreferencesDatasource,
  ConfigWebServiceDatasource,
  ColabFloorDatasource,
  ColabWebServiceDatasource,
  EquipFloorDatasource,
  EquipWebServiceDatasource,
  LocalFloorDatasource,
  LocalWebServiceDatasource,
  TerceiroFloorDatasource,
  TerceiroWebServiceDatasource,
  VisitanteFloorDatasource,
  VisitanteWebServiceDatasource,
])
main() {}
