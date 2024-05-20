import 'package:pcp/app_module.dart';
import 'package:pcp/infra/datasource/shared_preferences/config_shared_preferences_datasource.dart';
import 'package:pcp/infra/model/shared_preferences/config_shared_preferences_model.dart';
import 'package:pcp/utils/constant.dart';

class ConfigSharedPreferencesDatasourceImpl
    implements ConfigSharedPreferencesDatasource {

  final LocalStorage localStorage;
  ConfigSharedPreferencesDatasourceImpl(this.localStorage);

  @override
  Future<ConfigSharedPreferencesModel> getConfig() async {
    final ret = await localStorage.get(BASE_SHARE_PREFERENCES_TABLE_CONFIG);
    return ConfigSharedPreferencesModel.fromJson(ret);
  }

  @override
  Future<bool> hasConfig() async {
    final ret = await localStorage.get(BASE_SHARE_PREFERENCES_TABLE_CONFIG);
    if (ret == '') {
      return false;
    }
    return true;
  }

  @override
  Future<void> salveConfig(
      ConfigSharedPreferencesModel configSharedPreferencesModel) async {
    return await localStorage.save(
      BASE_SHARE_PREFERENCES_TABLE_CONFIG,
      configSharedPreferencesModel.toJson(),
    );
  }
}
