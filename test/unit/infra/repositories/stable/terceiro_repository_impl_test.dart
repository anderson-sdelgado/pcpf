import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/entities/stable/terceiro.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/infra/model/floor/stable/terceiro_floor_model.dart';
import 'package:pcp/infra/model/web_service/stable/terceiro_web_service_model.dart';
import 'package:pcp/infra/repositories/stable/terceiro_repository_impl.dart';

import '../../datasource/mock_datasource.mocks.dart';

main() {
  final terceiroWebServiceDatasource = MockTerceiroWebServiceDatasource();
  final terceiroFloorDatasource = MockTerceiroFloorDatasource();
  final terceiroRepositoryImpl = TerceiroRepositoryImpl(
      terceiroFloorDatasource, terceiroWebServiceDatasource);
  final listTerceiro = [
    Terceiro(
      idTerceiro: 1,
      idBDTerceiro: 1,
      cpfTerceiro: "123.456.789-00",
      nomeTerceiro: "Teste",
      empresaTerceiro: "Terceiro Empresa",
    ),
  ];
  final listTerceiroWebServiceModelInput = [
    TerceiroWebServiceModelInput(
      idBDTerceiro: 1,
      cpfTerceiro: "123.456.789-00",
      nomeTerceiro: "Teste",
      empresaTerceiro: "Terceiro Empresa",
    ),
  ];
  final listTerceiroFloorModel = [
    TerceiroFloorModel(
      idTerceiro: 1,
      idBDTerceiro: 1,
      cpfTerceiro: "123.456.789-00",
      nomeTerceiro: "Teste",
      empresaTerceiro: "Terceiro Empresa",
    ),
  ];

  group('Test TerceiroRepositoryImpl', () {
    test('deve retornar true se apagar os dados', () async {
      when(terceiroFloorDatasource.deleteAllTerceiro())
          .thenAnswer((_) => Future(() => const Right(true)));
      final result = await terceiroRepositoryImpl.deleteAllTerceiro();
      expect(result.fold(id, id), true);
    });

    test('deve retornar false se tiver erro apagar os dados', () async {
      when(terceiroFloorDatasource.deleteAllTerceiro())
          .thenAnswer((_) => Future(() => Left(ErrorFloorDatasource("Erro"))));
      final result = await terceiroRepositoryImpl.deleteAllTerceiro();
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });

    test('deve retornar o list de Terceiro do web service', () async {
      when(terceiroWebServiceDatasource.getAllTerceiro("12345"))
          .thenAnswer((_) => Future(() => listTerceiroWebServiceModelInput));
      var result = await terceiroRepositoryImpl.recoverAllTerceiro("12345");
      expect(result.isRight(), true);
      expect(result.fold(id, id), listTerceiro);
    });

    test(
        'deve retornar Falhar de Integração de Dados de pegar dados dos Terceirooradores do web service',
        () async {
      when(terceiroWebServiceDatasource.getAllTerceiro("12345"))
          .thenThrow("Falha de Integração");
      var result = await terceiroRepositoryImpl.recoverAllTerceiro("12345");
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorRepository>());
    });

    test(
        'deve retornar false se tiver erro ao pegar dados dos Terceirooradores do web service',
        () async {
      when(terceiroWebServiceDatasource.getAllTerceiro("12345"))
          .thenThrow(ErrorWebServiceDatasource("Falha de Erro Conexão"));
      final result = await terceiroRepositoryImpl.recoverAllTerceiro("12345");
      expect(result.fold(id, id), isA<ErrorWebServiceDatasource>());
    });

    test('deve retornar true se salvar todos os dados', () async {
      when(terceiroFloorDatasource.addAllTerceiro(listTerceiroFloorModel))
          .thenAnswer((_) => Future(() => const Right(true)));
      final result = await terceiroRepositoryImpl.addAllTerceiro(listTerceiro);
      expect(result.fold(id, id), true);
    });

    test('deve retornar Falhar de Integração de Dados ao salvar todos os dados',
        () async {
      when(terceiroFloorDatasource.addAllTerceiro(listTerceiroFloorModel))
          .thenAnswer((_) => Future(() => Left(ErrorFloorDatasource("Erro"))));
      var result = await terceiroRepositoryImpl.addAllTerceiro(listTerceiro);
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });

    test('deve retornar Falhar de Integração de Dados ao salvar todos os dados',
        () async {
      when(terceiroFloorDatasource.addAllTerceiro(listTerceiroFloorModel))
          .thenAnswer((_) => Future(() => Left(ErrorRepository("Erro"))));
      var result = await terceiroRepositoryImpl.addAllTerceiro(listTerceiro);
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorRepository>());
    });
  });
}
