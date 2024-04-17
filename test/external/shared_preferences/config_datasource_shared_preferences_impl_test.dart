import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/external/shared_preferences/config_datasource_shared_preferences_impl.dart';
import 'package:pcp/infra/model/shared_preferences/config_shared_preferences_model.dart';
import 'package:pcp/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  late ConfigDatasourceSharedPreferencesImpl
      configDatasourceSharedPreferencesImpl;

  group('Test ConfigDatasourceSharedPreferencesImpl', () {
    test('deve retornar False se não tiver dados de Configuração', () async {
      SharedPreferences.setMockInitialValues({});

      configDatasourceSharedPreferencesImpl =
          ConfigDatasourceSharedPreferencesImpl(LocalStorage());

      var ret = await configDatasourceSharedPreferencesImpl.hasConfig();
      expect(ret, false);
    });

    test('deve retornar True se tiver dados de Configuração', () async {
      final data =
          ConfigSharedPreferencesModel(passwordConfig: "12345").toJson();
      SharedPreferences.setMockInitialValues(
          {BASE_SHARE_PREFERENCES_TABLE_CONFIG: data});
      configDatasourceSharedPreferencesImpl =
          ConfigDatasourceSharedPreferencesImpl(LocalStorage());

      var ret = await configDatasourceSharedPreferencesImpl.hasConfig();
      expect(ret, true);
    });

    test('deve retornar algum ConfigSharedPreferencesModel', () async {
      final data =
          ConfigSharedPreferencesModel(passwordConfig: "12345").toJson();
      SharedPreferences.setMockInitialValues(
          {BASE_SHARE_PREFERENCES_TABLE_CONFIG: data});
      configDatasourceSharedPreferencesImpl =
          ConfigDatasourceSharedPreferencesImpl(LocalStorage());

      var ret = await configDatasourceSharedPreferencesImpl.getConfig();
      expect(ret, isInstanceOf<ConfigSharedPreferencesModel>());
    });

    test('deve retornar algum ConfigSharedPreferencesModel com a senha 12345',
        () async {
      final data =
          ConfigSharedPreferencesModel(passwordConfig: "12345").toJson();
      SharedPreferences.setMockInitialValues(
          {BASE_SHARE_PREFERENCES_TABLE_CONFIG: data});
      configDatasourceSharedPreferencesImpl =
          ConfigDatasourceSharedPreferencesImpl(LocalStorage());

      var ret = await configDatasourceSharedPreferencesImpl.getConfig();
      var password = ret.passwordConfig;
      expect(password, "12345");
    });
  });
}
