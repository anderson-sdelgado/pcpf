import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/usecases/database/delete_all_visitante.dart';

import '../../repository/mock_repositories.mocks.dart';

main() {

  final visitanteRepository = MockVisitanteRepository();
  final deleteAllVisitante = DeleteAllVisitanteImpl(visitanteRepository);

  group('Test DeleteAllVisitante', () {

    test('deve retornar true se apagar os dados', () async {
      when(visitanteRepository.deleteAllVisitante()).thenAnswer((_) => Future(() => const Right(true)));
      final result = await deleteAllVisitante();
      expect(result.fold(id, id), true);
    });

    test('deve retornar false se tiver erro apagar os dados', () async {
      when(visitanteRepository.deleteAllVisitante()).thenAnswer((_) => Future(() => Left(ErrorFloorDatasource("Erro"))));
      final result = await deleteAllVisitante();
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });

  });

}