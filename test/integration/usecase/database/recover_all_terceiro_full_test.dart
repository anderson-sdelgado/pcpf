import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/repositories/stable/terceiro_repository.dart';
import 'package:pcp/domain/usecases/database/recover_all_terceiro.dart';

import '../../../unit/domain/repository/mock_repositories.mocks.dart';

main() {

  final configRepository = MockConfigRepository();

  group('Test RecoverAllTerceiro', () {
    test("Retorno sucesso para recuperar os dados", () async {
      WidgetsFlutterBinding.ensureInitialized();
      setup();
      when(configRepository.getNroAparelho())
          .thenAnswer((_) => Future(() => 16997417840));
      when(configRepository.getVersion())
          .thenAnswer((_) => Future(() => "1.00"));
      final terceiroRepository = await getIt.getAsync<TerceiroRepository>();
      final recoverAllTerceiro = RecoverAllTerceiroImpl(terceiroRepository,  configRepository);
      final result = await recoverAllTerceiro();
      expect(result.isRight(), true);
    });

  });
}