import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/entities/variable/config.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/variable/config_repository.dart';
import 'package:pcp/domain/usecases/initial/send_initial_config.dart';

import '../../repository/mock_repositories.mocks.dart';

main() {

  final configRepository = MockConfigRepository();
  final sendInitialConfigImpl = SendInitialConfigImpl(configRepository);

  group('Test SendInitialConfig', () {
    test('Teste de falha de Envio de Dados de Configurações', () async {
      final config = Config(
          nroAparelhoConfig: 169974178400,
          passwordConfig: "12345",
          version: "1.0"
      );
      when(configRepository.sendConfig(config)).thenAnswer((_) => Future(() => Left(ErrorConnection())));
      final result = await sendInitialConfigImpl("16997417840", "12345", "1.0");
      expect(result.isLeft(), true);
    });
  });
}
