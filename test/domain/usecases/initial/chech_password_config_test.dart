import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/repositories/variable/config_repository.dart';
import 'package:pcp/domain/usecases/initial/check_password_config.dart';

import '../../repository/mock_repositories.mocks.dart';


main() {
  final configRepository = MockConfigRepository();
  final checkPasswordConfig = CheckPasswordConfigImpl(configRepository);

  group('Test CheckPasswordConfig', () {
    test('deve retornar true se não tiver dados de configurações', () async {
      when(configRepository.hasConfig()).thenAnswer((_) => Future(() => false));
      bool result = await checkPasswordConfig("teste");
      expect(result, true);
    });

    test(
        'deve retornar false se tiver dados de configurações e retorna senha diferente',
        () async {
      when(configRepository.hasConfig()).thenAnswer((_) => Future(() => true));
      when(configRepository.getSenhaConfig())
          .thenAnswer((_) => Future(() => "senha"));
      bool result = await checkPasswordConfig("teste");
      expect(result, false);
    });

    test(
        'deve retornar true se tiver dados de configurações e retorna senha iguais',
        () async {
      when(configRepository.hasConfig()).thenAnswer((_) => Future(() => true));
      when(configRepository.getSenhaConfig())
          .thenAnswer((_) => Future(() => "senha"));
      bool result = await checkPasswordConfig("senha");
      expect(result, true);
    });
  });
}
