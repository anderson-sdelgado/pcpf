import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/usecases/initial/check_password_config.dart';
import 'package:pcp/infra/model/shared_preferences/config_shared_preferences_model.dart';
import 'package:pcp/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){

  Modular.init(AppModule());

  test("Checar integração usecase CheckPasswordConfig com dados SharePreferences", () async {
    final data = ConfigSharedPreferencesModel(passwordConfig: "12345").toJson();
    SharedPreferences.setMockInitialValues({
      BASE_SHARE_PREFERENCES_TABLE_CONFIG: data
    });
    final checkPasswordConfig = Modular.get<CheckPasswordConfig>();
    final ret = await checkPasswordConfig("12345");
    expect(ret, true);
  });

}