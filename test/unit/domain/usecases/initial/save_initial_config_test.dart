import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/entities/variable/config.dart';
import 'package:pcp/domain/usecases/initial/save_initial_config.dart';

import '../../repository/mock_repositories.mocks.dart';

main() {
  final configRepository = MockConfigRepository();
  final saveInitialConfigImpl = SaveInitialConfigImpl(configRepository);
  final config = Config(
    nroAparelhoConfig: 16997417840,
    passwordConfig: "12345",
    version: "1.0",
    idBDConfig: 1,
  );
  group('Test SaveInitialConfig', () {
    test("Teste execução de função", () async {
      when(configRepository.save(config)).thenAnswer((_) async {});
      final result = saveInitialConfigImpl(
        nroAparelho: "16997417840",
        senha: "12345",
        version: "1.0",
        idDB: 1,
      );
      expect(result, completes);
    });
  });
}
