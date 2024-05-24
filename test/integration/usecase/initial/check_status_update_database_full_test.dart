import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/entities/variable/config.dart';
import 'package:pcp/domain/usecases/initial/check_status_update_database.dart';
import 'package:pcp/infra/model/shared_preferences/config_shared_preferences_model.dart';
import 'package:pcp/utils/constant.dart';
import 'package:pcp/utils/enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  group('Test CheckStatusUpdateDatabase', () {
    test('deve retornar true se o update dos dados tiverem OK', () async {
      setup();
      final config = Config(
        nroAparelhoConfig: 16997417840,
        passwordConfig: "12345",
        version: "1.00",
        idBDConfig: 1,
        flagUpdate: FlagUpdate.UPDATED,
      );
      final configModel =
          ConfigSharedPreferencesModel.toConfigSharedPreferencesModel(config)
              .toJson();
      SharedPreferences.setMockInitialValues(
          {BASE_SHARE_PREFERENCES_TABLE_CONFIG: configModel});
      final checkStatusUpdateDatabase = getIt<CheckStatusUpdateDatabase>();
      final ret = await checkStatusUpdateDatabase();
      expect(ret, true);
    });
  });
}
