import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/usecases/initial/check_password_config.dart';

import '../../repository/mock_repositories.mocks.dart';


main() {
  final configRepository = MockConfigRepository();
  final checkPasswordConfig = CheckPasswordConfigImpl(configRepository);

  group('Test CheckPasswordConfig', () {
    test('deve retornar true se não tiver dados de configurações', () async {
      when(configRepository.has()).thenAnswer((_) => Future(() => false));
      bool result = await checkPasswordConfig("teste");
      expect(result, true);
    });

    test(
        'deve retornar false se tiver dados de configurações e retorna senha diferente',
        () async {
      when(configRepository.has()).thenAnswer((_) => Future(() => true));
      when(configRepository.getSenha())
          .thenAnswer((_) => Future(() => "senha"));
      bool result = await checkPasswordConfig("teste");
      expect(result, false);
    });

    test(
        'deve retornar true se tiver dados de configurações e retorna senha iguais',
        () async {
      when(configRepository.has()).thenAnswer((_) => Future(() => true));
      when(configRepository.getSenha())
          .thenAnswer((_) => Future(() => "senha"));
      bool result = await checkPasswordConfig("senha");
      expect(result, true);
    });
  });
}
