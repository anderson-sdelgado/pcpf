import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/usecases/database/delete_all_equip.dart';

import '../../repository/mock_repositories.mocks.dart';

main() {

  final equipRepository = MockEquipRepository();
  final deleteAllEquip = DeleteAllEquipImpl(equipRepository);

  group('Test DeleteAllEquip', () {

    test('deve retornar true se apagar os dados', () async {
      when(equipRepository.deleteAllEquip()).thenAnswer((_) => Future(() => const Right(true)));
      final result = await deleteAllEquip();
      expect(result.fold(id, id), true);
    });

    test('deve retornar false se tiver erro apagar os dados', () async {
      when(equipRepository.deleteAllEquip()).thenAnswer((_) => Future(() => Left(ErrorFloorDatasource("Erro"))));
      final result = await deleteAllEquip();
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });

  });

}