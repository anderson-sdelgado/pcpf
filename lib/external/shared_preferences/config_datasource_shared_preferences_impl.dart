import 'package:pcp/app_module.dart';
import 'package:pcp/infra/datasource/shared_preferences/config_datasource_shared_preferences.dart';
import 'package:pcp/infra/model/shared_preferences/config_shared_preferences_model.dart';
import 'package:pcp/utils/constant.dart';

class ConfigDatasourceSharedPreferencesImpl
    implements ConfigDatasourceSharedPreferences {
  final LocalStorage localStorage;
  ConfigDatasourceSharedPreferencesImpl(this.localStorage);

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
}
