import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/repositories/stable/equip_repository.dart';
import 'package:pcp/domain/usecases/database/recover_all_equip.dart';

import '../../../unit/domain/repository/mock_repositories.mocks.dart';

main() {

  final configRepository = MockConfigRepository();

  group('Test RecoverAllEquip', () {
    test("Retorno sucesso para recuperar os dados", () async {
      WidgetsFlutterBinding.ensureInitialized();
      setup();
      when(configRepository.getNroAparelho())
          .thenAnswer((_) => Future(() => 16997417840));
      when(configRepository.getVersion())
          .thenAnswer((_) => Future(() => "1.00"));
      final equipRepository = await getIt.getAsync<EquipRepository>();
      final recoverAllEquip = RecoverAllEquipImpl(equipRepository,  configRepository);
      final result = await recoverAllEquip();
      expect(result.isRight(), true);
    });

  });
}
