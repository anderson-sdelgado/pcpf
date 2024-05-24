import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/repositories/stable/colab_repository.dart';
import 'package:pcp/domain/usecases/database/add_all_colab.dart';
import 'package:pcp/external/floor/app_database.dart';
import 'package:pcp/external/floor/stable/colab_floor_datasource_impl.dart';
import 'package:pcp/external/floor/stable/equip_floor_datasource_impl.dart';
import 'package:pcp/external/floor/stable/local_floor_datasource_impl.dart';
import 'package:pcp/external/floor/stable/terceiro_floor_datasource_impl.dart';
import 'package:pcp/external/floor/stable/visitante_floor_datasource_impl.dart';
import 'package:pcp/external/shared_preferences/config_shared_preferences_datasource_impl.dart';
import 'package:pcp/external/web_service/stable/colab_web_service_datasource_impl.dart';
import 'package:pcp/external/web_service/stable/equip_web_service_datasource_impl.dart';
import 'package:pcp/external/web_service/stable/local_web_service_datasource_impl.dart';
import 'package:pcp/external/web_service/stable/terceiro_web_service_datasource_impl.dart';
import 'package:pcp/external/web_service/stable/visitante_web_service_datasource_impl.dart';
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
import 'package:pcp/infra/repositories/stable/colab_repository_impl.dart';

void main() {
  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    setup();
  });

  test('Dio ', () async {
    final object = getIt<Dio>();
    expect(object, isA<Dio>());
  });

  test('Test Floor', () async {
    final object = await getIt.getAsync<AppDatabase>();
    expect(object, isA<AppDatabase>());
  });

  test('Test LocalStorage', () {
    final object = getIt.get<LocalStorage>();
    expect(object, isA<LocalStorage>());
  });

  test('Test ConfigSharedPreferencesDatasource', () async {
    final object = getIt<ConfigSharedPreferencesDatasource>();
    expect(object, isA<ConfigSharedPreferencesDatasourceImpl>());
  });

  test('Test ColabWebServiceDatasource', () async {
    final object = getIt<ColabWebServiceDatasource>();
    expect(object, isA<ColabWebServiceDatasourceImpl>());
  });

  test('Test EquipWebServiceDatasource', () async {
    final object = getIt<EquipWebServiceDatasource>();
    expect(object, isA<EquipWebServiceDatasourceImpl>());
  });

  test('Test LocalWebServiceDatasource', () async {
    final object = getIt<LocalWebServiceDatasource>();
    expect(object, isA<LocalWebServiceDatasourceImpl>());
  });

  test('Test TerceiroWebServiceDatasource', () async {
    final object = getIt<TerceiroWebServiceDatasource>();
    expect(object, isA<TerceiroWebServiceDatasourceImpl>());
  });

  test('Test VisitanteWebServiceDatasource', () async {
    final object = getIt<VisitanteWebServiceDatasource>();
    expect(object, isA<VisitanteWebServiceDatasourceImpl>());
  });

  test('Test ColabFloorDatasource', () async {
    final object = await getIt.getAsync<ColabFloorDatasource>();
    expect(object, isA<ColabFloorDatasourceImpl>());
  });

  test('Test EquipFloorDatasource', () async {
    final object = await getIt.getAsync<EquipFloorDatasource>();
    expect(object, isA<EquipFloorDatasourceImpl>());
  });

  test('Test LocalFloorDatasource', () async {
    final object = await getIt.getAsync<LocalFloorDatasource>();
    expect(object, isA<LocalFloorDatasourceImpl>());
  });

  test('Test TerceiroFloorDatasource', () async {
    final object = await getIt.getAsync<TerceiroFloorDatasource>();
    expect(object, isA<TerceiroFloorDatasourceImpl>());
  });

  test('Test VisitanteFloorDatasource', () async {
    final object = await getIt.getAsync<VisitanteFloorDatasource>();
    expect(object, isA<VisitanteFloorDatasourceImpl>());
  });

  test('Test ColabRepository', () async {
    final object = await getIt.getAsync<ColabRepository>();
    expect(object, isA<ColabRepositoryImpl>());
  });

  test('Test AddAllColab', () async {
    final object = await getIt.getAsync<AddAllColab>();
    expect(object, isA<AddAllColabImpl>());
  });
}
