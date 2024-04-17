import 'package:pcp/infra/model/shared_preferences/config_shared_preferences_model.dart';

abstract class ConfigDatasourceSharedPreferences {
  Future<bool> hasConfig();
  Future<ConfigSharedPreferencesModel> getConfig();
}