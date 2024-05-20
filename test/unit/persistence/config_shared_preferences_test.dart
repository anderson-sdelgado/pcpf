import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/infra/model/shared_preferences/config_shared_preferences_model.dart';
import 'package:pcp/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main () {

  test("Teste Config", () async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    final config = ConfigSharedPreferencesModel(
      nroAparelhoConfig: 16997417840,
      passwordConfig: "12345",
      version: "1.0",
      idBDConfig: 1,
    );
    final localStorage = LocalStorage();
    await localStorage.save(BASE_SHARE_PREFERENCES_TABLE_CONFIG, config.toJson());
    final result = await localStorage.get(BASE_SHARE_PREFERENCES_TABLE_CONFIG);
    expect(ConfigSharedPreferencesModel.fromJson(result), config);
  });

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
