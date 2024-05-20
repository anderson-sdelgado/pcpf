import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/entities/variable/config.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/usecases/initial/send_initial_config.dart';

import '../../repository/mock_repositories.mocks.dart';

main() {
  final configRepository = MockConfigRepository();
  final sendInitialConfigImpl = SendInitialConfigImpl(configRepository);
  final config = Config(
      nroAparelhoConfig: 16997417840, passwordConfig: "12345", version: "1.0");

  group('Test SendInitialConfig', () {
    test(
        'Teste de Falha Conexão no Web Service no Envio de Dados de Configurações',
        () async {
      when(configRepository.send(config))
          .thenAnswer((_) => Future(() => Left(ErrorWebServiceDatasource("Erro 404"))));
      final result = await sendInitialConfigImpl(
        nroAparelho: "16997417840",
        senha: "12345",
        version: "1.0",
      );
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorWebServiceDatasource>());
    });

    test(
        'Teste de Falha Integração de Dados no Envio de Dados de Configurações',
        () async {
      when(configRepository.send(config)).thenAnswer(
          (_) => Future(() => Left(ErrorRepository("Erro na Integração"))));
      final result = await sendInitialConfigImpl(
        nroAparelho: "16997417840",
        senha: "12345",
        version: "1.0",
      );
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorRepository>());
    });

    test('Teste de Sucesso de Envio de Dados de Configurações', () async {
      when(configRepository.send(config))
          .thenAnswer((_) => Future(() => const Right(1)));
      final result = await sendInitialConfigImpl(
        nroAparelho: "16997417840",
        senha: "12345",
        version: "1.0",
      );
      expect(result.isRight(), true);
      expect(result.fold(id, id), 1);
    });
  });
}
