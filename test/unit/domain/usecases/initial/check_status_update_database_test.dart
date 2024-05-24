import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/usecases/initial/check_status_update_database.dart';
import 'package:pcp/utils/enum.dart';

import '../../repository/mock_repositories.mocks.dart';


main() {
  final configRepository = MockConfigRepository();
  final checkStatusUpdateDatabase = CheckStatusUpdateDatabaseImpl(configRepository);

  group('Test CheckPasswordConfig', () {
    test('deve retornar false se não tiver dados na tabela configuração', () async {
      when(configRepository.has()).thenAnswer((_) => Future(() => false));
      bool result = await checkStatusUpdateDatabase();
      expect(result, false);
    });

    test('deve retornar false se não tiver atualizado todas as tabelas do aplicativo', () async {
      when(configRepository.has()).thenAnswer((_) => Future(() => true));
      when(configRepository.getFlagUpdate()).thenAnswer((_) => Future(() => FlagUpdate.OUTDATED));
      bool result = await checkStatusUpdateDatabase();
      expect(result, false);
    });

    test('deve retornar true se tiver atualizado todas as tabelas do aplicativo', () async {
      when(configRepository.has()).thenAnswer((_) => Future(() => true));
      when(configRepository.getFlagUpdate()).thenAnswer((_) => Future(() => FlagUpdate.OUTDATED));
      bool result = await checkStatusUpdateDatabase();
      expect(result, false);
    });
  });
}