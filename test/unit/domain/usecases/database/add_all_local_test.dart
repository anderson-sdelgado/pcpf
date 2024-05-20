import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/entities/stable/local.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/usecases/database/add_all_local.dart';

import '../../repository/mock_repositories.mocks.dart';

main() {
  final localRepository = MockLocalRepository();
  final addAllLocal = AddAllLocalImpl(localRepository);

  final List<Local> localList = [
    Local(
      idLocal: 1,
      descrLocal: "Usina",
    ),
  ];

  group('Test AddAllLocal', () {
    test('deve retornar true se todos os dados foram salvo', () async {
      when(localRepository.addAllLocal(localList))
          .thenAnswer((_) => Future(() => const Right(true)));
      final result = await addAllLocal(localList);
      expect(result.fold(id, id), true);
    });

    test('deve retornar false se tiver erro apagar os dados', () async {
      when(localRepository.addAllLocal(localList))
          .thenAnswer((_) => Future(() => Left(ErrorFloorDatasource("Erro"))));
      final result = await addAllLocal(localList);
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });
  });
}
