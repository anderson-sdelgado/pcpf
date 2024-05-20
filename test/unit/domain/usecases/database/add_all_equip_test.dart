import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/entities/stable/equip.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/usecases/database/add_all_equip.dart';

import '../../repository/mock_repositories.mocks.dart';

main() {
  final equipRepository = MockEquipRepository();
  final addAllEquip = AddAllEquipImpl(equipRepository);

  final List<Equip> equipList = [
    Equip(
      idEquip: 1,
      nroEquip: 100,
    ),
  ];

  group('Test AddAllEquip', () {
    test('deve retornar true se todos os dados foram salvo', () async {
      when(equipRepository.addAllEquip(equipList))
          .thenAnswer((_) => Future(() => const Right(true)));
      final result = await addAllEquip(equipList);
      expect(result.fold(id, id), true);
    });

    test('deve retornar false se tiver erro apagar os dados', () async {
      when(equipRepository.addAllEquip(equipList))
          .thenAnswer((_) => Future(() => Left(ErrorFloorDatasource("Erro"))));
      final result = await addAllEquip(equipList);
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });
  });
}
