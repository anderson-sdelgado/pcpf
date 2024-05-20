import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/entities/stable/terceiro.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/usecases/database/add_all_terceiro.dart';

import '../../repository/mock_repositories.mocks.dart';

main() {
  final terceiroRepository = MockTerceiroRepository();
  final addAllTerceiro = AddAllTerceiroImpl(terceiroRepository);

  final List<Terceiro> terceiroList = [
    Terceiro(
      idTerceiro: 1,
      idBDTerceiro: 1,
      cpfTerceiro: "123.456.789-00",
      nomeTerceiro: "Teste",
      empresaTerceiro: "Terceiro Empresa",
    ),
  ];

  group('Test AddAllTerceiro', () {
    test('deve retornar true se todos os dados foram salvo', () async {
      when(terceiroRepository.addAllTerceiro(terceiroList))
          .thenAnswer((_) => Future(() => const Right(true)));
      final result = await addAllTerceiro(terceiroList);
      expect(result.fold(id, id), true);
    });

    test('deve retornar false se tiver erro apagar os dados', () async {
      when(terceiroRepository.addAllTerceiro(terceiroList))
          .thenAnswer((_) => Future(() => Left(ErrorFloorDatasource("Erro"))));
      final result = await addAllTerceiro(terceiroList);
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });
  });
}
