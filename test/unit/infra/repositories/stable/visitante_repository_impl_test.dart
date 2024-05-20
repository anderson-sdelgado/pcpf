import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/entities/stable/visitante.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/infra/model/floor/stable/visitante_floor_model.dart';
import 'package:pcp/infra/model/web_service/stable/visitante_web_service_model.dart';
import 'package:pcp/infra/repositories/stable/visitante_repository_impl.dart';

import '../../datasource/mock_datasource.mocks.dart';

main() {
  final visitanteWebServiceDatasource = MockVisitanteWebServiceDatasource();
  final visitanteFloorDatasource = MockVisitanteFloorDatasource();
  final visitanteRepositoryImpl = VisitanteRepositoryImpl(
      visitanteFloorDatasource, visitanteWebServiceDatasource);
  final listVisitante = [
    Visitante(
      idVisitante: 1,
      cpfVisitante: "123.456.789-00",
      nomeVisitante: "Teste",
      empresaVisitante: "Visitante Empresa",
    ),
  ];
  final listVisitanteWebServiceModelInput = [
    VisitanteWebServiceModelInput(
      idVisitante: 1,
      cpfVisitante: "123.456.789-00",
      nomeVisitante: "Teste",
      empresaVisitante: "Visitante Empresa",
    ),
  ];
  final listVisitanteFloorModel = [
    VisitanteFloorModel(
      idVisitante: 1,
      cpfVisitante: "123.456.789-00",
      nomeVisitante: "Teste",
      empresaVisitante: "Visitante Empresa",
    ),
  ];

  group('Test VisitanteRepositoryImpl', () {
    test('deve retornar true se apagar os dados', () async {
      when(visitanteFloorDatasource.deleteAllVisitante())
          .thenAnswer((_) => Future(() => const Right(true)));
      final result = await visitanteRepositoryImpl.deleteAllVisitante();
      expect(result.fold(id, id), true);
    });

    test('deve retornar false se tiver erro apagar os dados', () async {
      when(visitanteFloorDatasource.deleteAllVisitante())
          .thenAnswer((_) => Future(() => Left(ErrorFloorDatasource("Erro"))));
      final result = await visitanteRepositoryImpl.deleteAllVisitante();
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });

    test('deve retornar o list de Visitante do web service', () async {
      when(visitanteWebServiceDatasource.getAllVisitante("12345"))
          .thenAnswer((_) => Future(() => listVisitanteWebServiceModelInput));
      var result = await visitanteRepositoryImpl.recoverAllVisitante("12345");
      expect(result.isRight(), true);
      expect(result.fold(id, id), listVisitante);
    });

    test(
        'deve retornar Falhar de Integração de Dados de pegar dados dos Visitanteoradores do web service',
        () async {
      when(visitanteWebServiceDatasource.getAllVisitante("12345"))
          .thenThrow("Falha de Integração");
      var result = await visitanteRepositoryImpl.recoverAllVisitante("12345");
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorRepository>());
    });

    test(
        'deve retornar false se tiver erro ao pegar dados dos Visitanteoradores do web service',
        () async {
      when(visitanteWebServiceDatasource.getAllVisitante("12345"))
          .thenThrow(ErrorWebServiceDatasource("Falha de Erro Conexão"));
      final result = await visitanteRepositoryImpl.recoverAllVisitante("12345");
      expect(result.fold(id, id), isA<ErrorWebServiceDatasource>());
    });

    test('deve retornar true se salvar todos os dados', () async {
      when(visitanteFloorDatasource.addAllVisitante(listVisitanteFloorModel))
          .thenAnswer((_) => Future(() => const Right(true)));
      final result = await visitanteRepositoryImpl.addAllVisitante(listVisitante);
      expect(result.fold(id, id), true);
    });

    test('deve retornar Falhar de Integração de Dados ao salvar todos os dados',
        () async {
      when(visitanteFloorDatasource.addAllVisitante(listVisitanteFloorModel))
          .thenAnswer((_) => Future(() => Left(ErrorFloorDatasource("Erro"))));
      var result = await visitanteRepositoryImpl.addAllVisitante(listVisitante);
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });

    test('deve retornar Falhar de Integração de Dados ao salvar todos os dados',
        () async {
      when(visitanteFloorDatasource.addAllVisitante(listVisitanteFloorModel))
          .thenAnswer((_) => Future(() => Left(ErrorRepository("Erro"))));
      var result = await visitanteRepositoryImpl.addAllVisitante(listVisitante);
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorRepository>());
    });
  });
}

