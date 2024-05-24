import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/usecases/initial/send_initial_config.dart';

main() {
  group('Test SendInitialConfig', () {
    test('deve retornar o Id do Web service com conexão', () async {
      WidgetsFlutterBinding.ensureInitialized();
      setup();
      final sendInitialConfig = getIt<SendInitialConfig>();
      var result = await sendInitialConfig(
        nroAparelho: "16997417840",
        version: "1.00",
        senha: "12345",
      );
      expect(result.isRight(), true);
    });
  });
}
