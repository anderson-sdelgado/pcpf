import 'package:dio/dio.dart';
import 'package:floor/floor.dart';
import 'package:get_it/get_it.dart';
import 'package:pcp/domain/repositories/stable/colab_repository.dart';
import 'package:pcp/domain/repositories/stable/local_repository.dart';
import 'package:pcp/domain/repositories/stable/terceiro_repository.dart';
import 'package:pcp/domain/repositories/stable/visitante_repository.dart';
import 'package:pcp/domain/repositories/variable/config_repository.dart';
import 'package:pcp/domain/usecases/database/add_all_colab.dart';
import 'package:pcp/domain/usecases/database/add_all_equip.dart';
import 'package:pcp/domain/usecases/database/add_all_local.dart';
import 'package:pcp/domain/usecases/database/add_all_terceiro.dart';
import 'package:pcp/domain/usecases/database/add_all_visitante.dart';
import 'package:pcp/domain/usecases/database/delete_all_colab.dart';
import 'package:pcp/domain/usecases/database/delete_all_equip.dart';
import 'package:pcp/domain/usecases/database/delete_all_local.dart';
import 'package:pcp/domain/usecases/database/delete_all_terceiro.dart';
import 'package:pcp/domain/usecases/database/delete_all_visitante.dart';
import 'package:pcp/domain/usecases/database/recover_all_colab.dart';
import 'package:pcp/domain/usecases/database/recover_all_equip.dart';
import 'package:pcp/domain/usecases/database/recover_all_local.dart';
import 'package:pcp/domain/usecases/database/recover_all_terceiro.dart';
import 'package:pcp/domain/usecases/database/recover_all_visitante.dart';
import 'package:pcp/domain/usecases/initial/check_password_config.dart';
import 'package:pcp/domain/usecases/initial/check_status_update_database.dart';
import 'package:pcp/domain/usecases/initial/save_initial_config.dart';
import 'package:pcp/domain/usecases/initial/send_initial_config.dart';
import 'package:pcp/domain/usecases/initial/set_config_all_database_update.dart';
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
import 'package:pcp/external/web_service/variable/config_web_service_datasource_impl.dart';
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
import 'package:pcp/infra/repositories/stable/colab_repository_impl.dart';
import 'package:pcp/infra/repositories/stable/local_repository_impl.dart';
import 'package:pcp/infra/repositories/stable/terceiro_repository_impl.dart';
import 'package:pcp/infra/repositories/stable/visitante_repository_impl.dart';
import 'package:pcp/infra/repositories/variable/config_repository_impl.dart';
import 'package:pcp/presenter/initial/config/cubit/config_cubit.dart';
import 'package:pcp/presenter/initial/matric_vigia/cubit/matric_vigia_cubit.dart';
import 'package:pcp/presenter/initial/menu_inicial/cubit/menu_inicial_cubit.dart';
import 'package:pcp/presenter/initial/senha/cubit/senha_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/repositories/stable/equip_repository.dart';
import 'infra/repositories/stable/equip_repository_impl.dart';

final getIt = GetIt.instance;

void setup({bool test = false}) {
  // Persistence //
  getIt.registerSingleton<Dio>(Dio());

  getIt.registerFactory(() => LocalStorage());

  if (test) {
    getIt.registerSingletonAsync<AppDatabase>(() async => $FloorAppDatabase
        .inMemoryDatabaseBuilder()
        .addCallback(callback)
        .build());
  } else {
    getIt.registerSingletonAsync<AppDatabase>(() async => $FloorAppDatabase
        .databaseBuilder('pcp.db')
        .addCallback(callback)
        .build());
  }

  // ------------ //

  // Datasource //

  //// SharedPreferences ////

  getIt.registerFactory<ConfigSharedPreferencesDatasource>(
      () => ConfigSharedPreferencesDatasourceImpl(getIt()));
  //// ------------ ////

  //// WebService ////

  ////// Stable //////

  getIt.registerFactory<ColabWebServiceDatasource>(
      () => ColabWebServiceDatasourceImpl(getIt()));

  getIt.registerFactory<EquipWebServiceDatasource>(
      () => EquipWebServiceDatasourceImpl(getIt()));

  getIt.registerFactory<LocalWebServiceDatasource>(
      () => LocalWebServiceDatasourceImpl(getIt()));

  getIt.registerFactory<TerceiroWebServiceDatasource>(
      () => TerceiroWebServiceDatasourceImpl(getIt()));

  getIt.registerFactory<VisitanteWebServiceDatasource>(
      () => VisitanteWebServiceDatasourceImpl(getIt()));

  ////// -------- //////

  ////// Variable //////

  getIt.registerFactory<ConfigWebServiceDatasource>(
      () => ConfigWebServiceDatasourceImpl(getIt()));

  ////// -------- //////

  //// ------------ ////

  //// Room ////

  ////// Stable //////

  getIt.registerSingletonWithDependencies<ColabFloorDatasource>(
      () => ColabFloorDatasourceImpl(getIt()),
      dependsOn: [AppDatabase]);

  getIt.registerSingletonWithDependencies<EquipFloorDatasource>(
      () => EquipFloorDatasourceImpl(getIt()),
      dependsOn: [AppDatabase]);

  getIt.registerSingletonWithDependencies<LocalFloorDatasource>(
      () => LocalFloorDatasourceImpl(getIt()),
      dependsOn: [AppDatabase]);

  getIt.registerSingletonWithDependencies<TerceiroFloorDatasource>(
      () => TerceiroFloorDatasourceImpl(getIt()),
      dependsOn: [AppDatabase]);

  getIt.registerSingletonWithDependencies<VisitanteFloorDatasource>(
      () => VisitanteFloorDatasourceImpl(getIt()),
      dependsOn: [AppDatabase]);

  ////// ------------ //////

  //// ------------ ////

  // ------------ //

  // Repository //

  //// Stable ////

  getIt.registerSingletonWithDependencies<ColabRepository>(
      () => ColabRepositoryImpl(getIt(), getIt()),
      dependsOn: [AppDatabase]);

  getIt.registerSingletonWithDependencies<EquipRepository>(
      () => EquipRepositoryImpl(getIt(), getIt()),
      dependsOn: [AppDatabase]);

  getIt.registerSingletonWithDependencies<LocalRepository>(
      () => LocalRepositoryImpl(getIt(), getIt()),
      dependsOn: [AppDatabase]);

  getIt.registerSingletonWithDependencies<TerceiroRepository>(
      () => TerceiroRepositoryImpl(getIt(), getIt()),
      dependsOn: [AppDatabase]);

  getIt.registerSingletonWithDependencies<VisitanteRepository>(
      () => VisitanteRepositoryImpl(getIt(), getIt()),
      dependsOn: [AppDatabase]);

  //// ------------ ////

  //// Variable ////

  getIt.registerFactory<ConfigRepository>(
      () => ConfigRepositoryImpl(getIt(), getIt()));

  //// ------------ ////

  // ------------ //

  // Usecase //

  //// Database ////

  getIt.registerSingletonWithDependencies<AddAllColab>(
      () => AddAllColabImpl(getIt()),
      dependsOn: [AppDatabase]);

  getIt.registerSingletonWithDependencies<AddAllEquip>(
      () => AddAllEquipImpl(getIt()),
      dependsOn: [AppDatabase]);

  getIt.registerSingletonWithDependencies<AddAllLocal>(
      () => AddAllLocalImpl(getIt()),
      dependsOn: [AppDatabase]);

  getIt.registerSingletonWithDependencies<AddAllTerceiro>(
      () => AddAllTerceiroImpl(getIt()),
      dependsOn: [AppDatabase]);

  getIt.registerSingletonWithDependencies<AddAllVisitante>(
      () => AddAllVisitanteImpl(getIt()),
      dependsOn: [AppDatabase]);

  getIt.registerSingletonWithDependencies<DeleteAllColab>(
      () => DeleteAllColabImpl(getIt()),
      dependsOn: [AppDatabase]);

  getIt.registerSingletonWithDependencies<DeleteAllEquip>(
      () => DeleteAllEquipImpl(getIt()),
      dependsOn: [AppDatabase]);

  getIt.registerSingletonWithDependencies<DeleteAllLocal>(
      () => DeleteAllLocalImpl(getIt()),
      dependsOn: [AppDatabase]);

  getIt.registerSingletonWithDependencies<DeleteAllTerceiro>(
      () => DeleteAllTerceiroImpl(getIt()),
      dependsOn: [AppDatabase]);

  getIt.registerSingletonWithDependencies<DeleteAllVisitante>(
      () => DeleteAllVisitanteImpl(getIt()),
      dependsOn: [AppDatabase]);

  getIt.registerSingletonWithDependencies<RecoverAllColab>(
      () => RecoverAllColabImpl(
            getIt(),
            getIt(),
          ),
      dependsOn: [AppDatabase]);

  getIt.registerSingletonWithDependencies<RecoverAllEquip>(
      () => RecoverAllEquipImpl(
            getIt(),
            getIt(),
          ),
      dependsOn: [AppDatabase]);

  getIt.registerSingletonWithDependencies<RecoverAllLocal>(
      () => RecoverAllLocalImpl(
            getIt(),
            getIt(),
          ),
      dependsOn: [AppDatabase]);

  getIt.registerSingletonWithDependencies<RecoverAllTerceiro>(
      () => RecoverAllTerceiroImpl(
            getIt(),
            getIt(),
          ),
      dependsOn: [AppDatabase]);

  getIt.registerSingletonWithDependencies<RecoverAllVisitante>(
      () => RecoverAllVisitanteImpl(
            getIt(),
            getIt(),
          ),
      dependsOn: [AppDatabase]);

  //// ------------ ////

  //// Initial ////

  getIt.registerFactory<CheckPasswordConfig>(
      () => CheckPasswordConfigImpl(getIt()));

  getIt.registerFactory<CheckStatusUpdateDatabase>(
          () => CheckStatusUpdateDatabaseImpl(getIt()));

  getIt
      .registerFactory<SendInitialConfig>(() => SendInitialConfigImpl(getIt()));

  getIt
      .registerFactory<SaveInitialConfig>(() => SaveInitialConfigImpl(getIt()));

  getIt.registerFactory<SetConfigAllDatabaseUpdate>(
      () => SetConfigAllDatabaseUpdateImpl(getIt()));

  //// ------------ ////

  // ------------ //

  // Cubit //

  getIt.registerFactory(() => MenuInicialCubit(getIt()));
  getIt.registerFactory(() => SenhaCubit(getIt()));
  getIt.registerFactory(() => ConfigCubit(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ));
  getIt.registerFactory(() => MatricVigiaCubit());
  // ------------ //
}

class LocalStorage {
  save(String key, String value) async {
    final shared = await SharedPreferences.getInstance();
    shared.setString(key, value);
  }

  Future<String> get(String key) async {
    final shared = await SharedPreferences.getInstance();
    return shared.getString(key) ?? '';
  }
}

class LocalStorageTest {
  save(String key, String value) async {
    final shared = await SharedPreferences.getInstance();
    shared.setString(key, value);
  }

  Future<String> get(String key) async {
    final shared = await SharedPreferences.getInstance();
    return shared.getString(key) ?? '';
  }
}

class FloorAppDatabase {
  Future<AppDatabase> get async {
    return $FloorAppDatabase.databaseBuilder('pci.db').build();
  }
}

final callback = Callback(
  onCreate: (database, version) {
    /* database has been created */
  },
  onOpen: (database) {
    /* database has been opened */
  },
  onUpgrade: (database, startVersion, endVersion) {
    /* database has been upgraded */
  },
);
