import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/usecases/initial/check_password_config.dart';
import 'package:pcp/infra/model/shared_preferences/config_shared_preferences_model.dart';
import 'package:pcp/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {

  group('Test CheckPasswordConfig', () {
    test('deve retornar true se tiver dados de configurações e senha tiver OK', () async {
      setup();
      final data = ConfigSharedPreferencesModel(passwordConfig: "12345").toJson();
      SharedPreferences.setMockInitialValues({
        BASE_SHARE_PREFERENCES_TABLE_CONFIG: data
      });
      final checkPasswordConfig = getIt<CheckPasswordConfig>();
      final ret = await checkPasswordConfig("12345");
      expect(ret, true);
    });
  });
}