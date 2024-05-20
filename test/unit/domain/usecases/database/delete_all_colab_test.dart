import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/usecases/database/delete_all_colab.dart';

import '../../repository/mock_repositories.mocks.dart';

main() {

  final colabRepository = MockColabRepository();
  final deleteAllColab = DeleteAllColabImpl(colabRepository);

  group('Test DeleteAllColab', () {

    test('deve retornar true se apagar os dados', () async {
      when(colabRepository.deleteAllColab()).thenAnswer((_) => Future(() => const Right(true)));
      final result = await deleteAllColab();
      expect(result.fold(id, id), true);
    });

    test('deve retornar false se tiver erro apagar os dados', () async {
      when(colabRepository.deleteAllColab()).thenAnswer((_) => Future(() => Left(ErrorFloorDatasource("Erro"))));
      final result = await deleteAllColab();
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });

  });

}