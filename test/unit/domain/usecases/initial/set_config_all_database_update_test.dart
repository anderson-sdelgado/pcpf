import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/entities/variable/config.dart';
import 'package:pcp/domain/usecases/initial/set_config_all_database_update.dart';

import '../../repository/mock_repositories.mocks.dart';

main() {
  final configRepository = MockConfigRepository();
  final setConfigAllDatabaseUpdateImpl = SetConfigAllDatabaseUpdateImpl(configRepository);
  final config = Config(
    nroAparelhoConfig: 16997417840,
    passwordConfig: "12345",
    version: "1.0",
    idBDConfig: 1,
  );
  group('Test SetConfigAllDatabaseUpdate', () {
    test("Teste execução de função", () async {
      when(configRepository.getConfig()).thenAnswer((_) async => config);
      final result = setConfigAllDatabaseUpdateImpl();
      expect(result, completes);
    });
  });
}
