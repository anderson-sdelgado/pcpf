import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/entities/stable/local.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/infra/model/floor/stable/local_floor_model.dart';
import 'package:pcp/infra/model/web_service/stable/local_web_service_model.dart';
import 'package:pcp/infra/repositories/stable/local_repository_impl.dart';

import '../../datasource/mock_datasource.mocks.dart';

main() {
  final localWebServiceDatasource = MockLocalWebServiceDatasource();
  final localFloorDatasource = MockLocalFloorDatasource();
  final localRepositoryImpl =
      LocalRepositoryImpl(localFloorDatasource, localWebServiceDatasource);
  final listLocal = [
    Local(idLocal: 1, descrLocal: "Usina"),
  ];
  final listLocalWebServiceModelInput = [
    LocalWebServiceModelInput(idLocal: 1, descrLocal: "Usina"),
  ];
  final listLocalFloorModel = [
    LocalFloorModel(idLocal: 1, descrLocal: "Usina"),
  ];

  group('Test LocalRepositoryImpl', () {
    test('deve retornar true se apagar os dados', () async {
      when(localFloorDatasource.deleteAllLocal())
          .thenAnswer((_) => Future(() => const Right(true)));
      final result = await localRepositoryImpl.deleteAllLocal();
      expect(result.fold(id, id), true);
    });

    test('deve retornar false se tiver erro apagar os dados', () async {
      when(localFloorDatasource.deleteAllLocal())
          .thenAnswer((_) => Future(() => Left(ErrorFloorDatasource("Erro"))));
      final result = await localRepositoryImpl.deleteAllLocal();
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });

    test('deve retornar o list de Local do web service', () async {
      when(localWebServiceDatasource.getAllLocal("12345"))
          .thenAnswer((_) => Future(() => listLocalWebServiceModelInput));
      var result = await localRepositoryImpl.recoverAllLocal("12345");
      expect(result.isRight(), true);
      expect(result.fold(id, id), listLocal);
    });

    test(
        'deve retornar Falhar de Integração de Dados de pegar dados dos Localoradores do web service',
        () async {
      when(localWebServiceDatasource.getAllLocal("12345"))
          .thenThrow("Falha de Integração");
      var result = await localRepositoryImpl.recoverAllLocal("12345");
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorRepository>());
    });

    test(
        'deve retornar false se tiver erro ao pegar dados dos Localoradores do web service',
        () async {
      when(localWebServiceDatasource.getAllLocal("12345"))
          .thenThrow(ErrorWebServiceDatasource("Falha de Erro Conexão"));
      final result = await localRepositoryImpl.recoverAllLocal("12345");
      expect(result.fold(id, id), isA<ErrorWebServiceDatasource>());
    });

    test('deve retornar true se salvar todos os dados', () async {
      when(localFloorDatasource.addAllLocal(listLocalFloorModel))
          .thenAnswer((_) => Future(() => const Right(true)));
      final result = await localRepositoryImpl.addAllLocal(listLocal);
      expect(result.fold(id, id), true);
    });

    test('deve retornar Falhar de Integração de Dados ao salvar todos os dados',
        () async {
      when(localFloorDatasource.addAllLocal(listLocalFloorModel))
          .thenAnswer((_) => Future(() => Left(ErrorFloorDatasource("Erro"))));
      var result = await localRepositoryImpl.addAllLocal(listLocal);
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });

    test('deve retornar Falhar de Integração de Dados ao salvar todos os dados',
        () async {
      when(localFloorDatasource.addAllLocal(listLocalFloorModel))
          .thenAnswer((_) => Future(() => Left(ErrorRepository("Erro"))));
      var result = await localRepositoryImpl.addAllLocal(listLocal);
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorRepository>());
    });
  });
}
