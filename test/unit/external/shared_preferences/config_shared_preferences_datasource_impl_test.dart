import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/external/shared_preferences/config_shared_preferences_datasource_impl.dart';
import 'package:pcp/infra/model/shared_preferences/config_shared_preferences_model.dart';
import 'package:pcp/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  late ConfigSharedPreferencesDatasourceImpl
      configDatasourceSharedPreferencesImpl;

  group('Test ConfigPreferencesDatasourceSharedImpl', () {
    test('deve retornar False se não tiver dados de Configuração', () async {
      SharedPreferences.setMockInitialValues({});

      configDatasourceSharedPreferencesImpl =
          ConfigSharedPreferencesDatasourceImpl(LocalStorage());

      final result = await configDatasourceSharedPreferencesImpl.hasConfig();
      expect(result, false);
    });

    test('deve retornar True se tiver dados de Configuração', () async {
      final data =
          ConfigSharedPreferencesModel(passwordConfig: "12345").toJson();
      SharedPreferences.setMockInitialValues(
          {BASE_SHARE_PREFERENCES_TABLE_CONFIG: data});
      configDatasourceSharedPreferencesImpl =
          ConfigSharedPreferencesDatasourceImpl(LocalStorage());

      final result = await configDatasourceSharedPreferencesImpl.hasConfig();
      expect(result, true);
    });

    test('deve retornar algum ConfigSharedPreferencesModel', () async {
      final data =
          ConfigSharedPreferencesModel(passwordConfig: "12345").toJson();
      SharedPreferences.setMockInitialValues(
          {BASE_SHARE_PREFERENCES_TABLE_CONFIG: data});
      configDatasourceSharedPreferencesImpl =
          ConfigSharedPreferencesDatasourceImpl(LocalStorage());

      final result = await configDatasourceSharedPreferencesImpl.getConfig();
      expect(result, isInstanceOf<ConfigSharedPreferencesModel>());
    });

    test('deve retornar algum ConfigSharedPreferencesModel com a senha 12345',
        () async {
      final data =
          ConfigSharedPreferencesModel(passwordConfig: "12345").toJson();
      SharedPreferences.setMockInitialValues(
          {BASE_SHARE_PREFERENCES_TABLE_CONFIG: data});
      configDatasourceSharedPreferencesImpl =
          ConfigSharedPreferencesDatasourceImpl(LocalStorage());

      final result = await configDatasourceSharedPreferencesImpl.getConfig();
      var password = result.passwordConfig;
      expect(password, "12345");
    });

    test('deve salvar ConfigSharedPreferencesModel no SharedPrefences',
            () async {
              SharedPreferences.setMockInitialValues({});
              configDatasourceSharedPreferencesImpl =
                  ConfigSharedPreferencesDatasourceImpl(LocalStorage());
          final result =  configDatasourceSharedPreferencesImpl.salveConfig(ConfigSharedPreferencesModel(passwordConfig: "12345"));
          expect(result, completes);
        });
  });
}
