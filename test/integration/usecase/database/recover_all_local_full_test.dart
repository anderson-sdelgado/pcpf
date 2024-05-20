import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/repositories/stable/local_repository.dart';
import 'package:pcp/domain/usecases/database/recover_all_local.dart';

import '../../../unit/domain/repository/mock_repositories.mocks.dart';

main() {

  final configRepository = MockConfigRepository();

  group('Test RecoverAllLocal', () {
    test("Retorno sucesso para recuperar os dados", () async {
      WidgetsFlutterBinding.ensureInitialized();
      setup();
      when(configRepository.getNroAparelho())
          .thenAnswer((_) => Future(() => 16997417840));
      when(configRepository.getVersion())
          .thenAnswer((_) => Future(() => "1.00"));
      final localRepository = await getIt.getAsync<LocalRepository>();
      final recoverAllLocal = RecoverAllLocalImpl(localRepository,  configRepository);
      final result = await recoverAllLocal();
      expect(result.isRight(), true);
    });

  });
}