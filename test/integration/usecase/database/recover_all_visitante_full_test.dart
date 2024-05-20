import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/repositories/stable/visitante_repository.dart';
import 'package:pcp/domain/usecases/database/recover_all_visitante.dart';

import '../../../unit/domain/repository/mock_repositories.mocks.dart';

main() {

  final configRepository = MockConfigRepository();

  group('Test RecoverAllVisitante', () {
    test("Retorno sucesso para recuperar os dados", () async {
      WidgetsFlutterBinding.ensureInitialized();
      setup();
      when(configRepository.getNroAparelho())
          .thenAnswer((_) => Future(() => 16997417840));
      when(configRepository.getVersion())
          .thenAnswer((_) => Future(() => "1.00"));
      final visitanteRepository = await getIt.getAsync<VisitanteRepository>();
      final recoverAllVisitante = RecoverAllVisitanteImpl(visitanteRepository,  configRepository);
      final result = await recoverAllVisitante();
      expect(result.isRight(), true);
    });

  });
}