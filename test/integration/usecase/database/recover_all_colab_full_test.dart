import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/repositories/stable/colab_repository.dart';
import 'package:pcp/domain/usecases/database/recover_all_colab.dart';

import '../../../unit/domain/repository/mock_repositories.mocks.dart';

main() {

  final configRepository = MockConfigRepository();

  group('Test RecoverAllColab', () {
    test("Retorno sucesso para recuperar os dados", () async {
      WidgetsFlutterBinding.ensureInitialized();
      setup();
      when(configRepository.getNroAparelho())
          .thenAnswer((_) => Future(() => 16997417840));
      when(configRepository.getVersion())
          .thenAnswer((_) => Future(() => "1.00"));
      final colabRepository = await getIt.getAsync<ColabRepository>();
      final recoverAllColab = RecoverAllColabImpl(colabRepository,  configRepository);
      final result = await recoverAllColab();
      expect(result.isRight(), true);
    });

  });
}
