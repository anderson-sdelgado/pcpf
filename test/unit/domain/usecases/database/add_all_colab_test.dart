import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/entities/stable/colab.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/usecases/database/add_all_colab.dart';

import '../../repository/mock_repositories.mocks.dart';

main() {
  final colabRepository = MockColabRepository();
  final addAllColab = AddAllColabImpl(colabRepository);

  final List<Colab> colabList = [
    Colab(
      matricColab: 12345,
      nomeColab: "Anderson",
    ),
  ];

  group('Test AddAllColab', () {
    test('deve retornar true se todos os dados foram salvo', () async {
      when(colabRepository.addAllColab(colabList))
          .thenAnswer((_) => Future(() => const Right(true)));
      final result = await addAllColab(colabList);
      expect(result.fold(id, id), true);
    });

    test('deve retornar false se tiver erro apagar os dados', () async {
      when(colabRepository.addAllColab(colabList))
          .thenAnswer((_) => Future(() => Left(ErrorFloorDatasource("Erro"))));
      final result = await addAllColab(colabList);
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });
  });
}
