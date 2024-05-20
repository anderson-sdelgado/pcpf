import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/entities/stable/visitante.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/usecases/database/add_all_visitante.dart';

import '../../repository/mock_repositories.mocks.dart';

main() {
  final visitanteRepository = MockVisitanteRepository();
  final addAllVisitante = AddAllVisitanteImpl(visitanteRepository);

  final List<Visitante> visitanteList = [
    Visitante(
      idVisitante: 1,
      cpfVisitante: "123.456.789-00",
      nomeVisitante: "Teste",
      empresaVisitante: "Visitante Empresa",
    ),
  ];

  group('Test AddAllVisitante', () {
    test('deve retornar true se todos os dados foram salvo', () async {
      when(visitanteRepository.addAllVisitante(visitanteList))
          .thenAnswer((_) => Future(() => const Right(true)));
      final result = await addAllVisitante(visitanteList);
      expect(result.fold(id, id), true);
    });

    test('deve retornar false se tiver erro apagar os dados', () async {
      when(visitanteRepository.addAllVisitante(visitanteList))
          .thenAnswer((_) => Future(() => Left(ErrorFloorDatasource("Erro"))));
      final result = await addAllVisitante(visitanteList);
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });
  });
}
