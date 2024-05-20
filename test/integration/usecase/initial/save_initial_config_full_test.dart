import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/usecases/initial/save_initial_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  group('Test SaveInitialConfig', () {
    test('deve retornar true se tiver dados de configurações e senha tiver OK',
        () async {
      setup();
      SharedPreferences.setMockInitialValues({});
      final saveInitialConfig = getIt<SaveInitialConfig>();
      final result = saveInitialConfig(
        nroAparelho: "16997417840",
        senha: "12345",
        version: "1.0",
        idDB: 1,
      );
      expect(result, completes);
    });
  });
}
