import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/entities/stable/colab.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/infra/model/floor/stable/colab_floor_model.dart';
import 'package:pcp/infra/model/web_service/stable/colab_web_service_model.dart';
import 'package:pcp/infra/repositories/stable/colab_repository_impl.dart';

import '../../datasource/mock_datasource.mocks.dart';

main() {
  final colabWebServiceDatasource = MockColabWebServiceDatasource();
  final colabFloorDatasource = MockColabFloorDatasource();
  final colabRepositoryImpl =
      ColabRepositoryImpl(colabFloorDatasource, colabWebServiceDatasource);
  final listColab = [Colab(matricColab: 19759, nomeColab: "Anderson")];
  final listColabWebServiceModelInput = [
    ColabWebServiceModelInput(matricColab: 19759, nomeColab: "Anderson")
  ];
  final listColabFloorModel = [
    ColabFloorModel(matricColab: 19759, nomeColab: "Anderson")
  ];

  group('Test ColabRepositoryImpl', () {
    test('deve retornar true se apagar os dados', () async {
      when(colabFloorDatasource.deleteAllColab())
          .thenAnswer((_) => Future(() => const Right(true)));
      final result = await colabRepositoryImpl.deleteAllColab();
      expect(result.fold(id, id), true);
    });

    test('deve retornar false se tiver erro apagar os dados', () async {
      when(colabFloorDatasource.deleteAllColab())
          .thenAnswer((_) => Future(() => Left(ErrorFloorDatasource("Erro"))));
      final result = await colabRepositoryImpl.deleteAllColab();
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });

    test('deve retornar o list de Colab do web service', () async {
      when(colabWebServiceDatasource.getAllColab("12345"))
          .thenAnswer((_) => Future(() => listColabWebServiceModelInput));
      var result = await colabRepositoryImpl.recoverAllColab("12345");
      expect(result.isRight(), true);
      expect(result.fold(id, id), listColab);
    });

    test('deve retornar Falhar de Integração de Dados de pegar dados dos Colaboradores do web service', () async {
      when(colabWebServiceDatasource.getAllColab("12345"))
          .thenThrow("Falha de Integração");
      var result = await colabRepositoryImpl.recoverAllColab("12345");
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorRepository>());
    });

    test('deve retornar false se tiver erro ao pegar dados dos Colaboradores do web service', () async {
      when(colabWebServiceDatasource.getAllColab("12345"))
          .thenThrow(ErrorWebServiceDatasource("Falha de Erro Conexão"));
      final result = await colabRepositoryImpl.recoverAllColab("12345");
      expect(result.fold(id, id), isA<ErrorWebServiceDatasource>());
    });

    test('deve retornar true se salvar todos os dados', () async {
      when(colabFloorDatasource.addAllColab(listColabFloorModel))
          .thenAnswer((_) => Future(() => const Right(true)));
      final result = await colabRepositoryImpl.addAllColab(listColab);
      expect(result.fold(id, id), true);
    });

    test('deve retornar Falhar de Integração de Dados ao salvar todos os dados', () async {
      when(colabFloorDatasource.addAllColab(listColabFloorModel))
          .thenAnswer((_) => Future(() => Left(ErrorFloorDatasource("Erro"))));
      var result = await colabRepositoryImpl.addAllColab(listColab);
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });

    test('deve retornar Falhar de Integração de Dados ao salvar todos os dados', () async {
      when(colabFloorDatasource.addAllColab(listColabFloorModel))
          .thenAnswer((_) => Future(() => Left(ErrorRepository("Erro"))));
      var result = await colabRepositoryImpl.addAllColab(listColab);
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorRepository>());
    });

  });
}
