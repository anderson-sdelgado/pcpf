import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/entities/stable/equip.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/infra/model/floor/stable/equip_floor_model.dart';
import 'package:pcp/infra/model/web_service/stable/equip_web_service_model.dart';
import 'package:pcp/infra/repositories/stable/equip_repository_impl.dart';

import '../../datasource/mock_datasource.mocks.dart';

main() {
  final equipWebServiceDatasource = MockEquipWebServiceDatasource();
  final equipFloorDatasource = MockEquipFloorDatasource();
  final equipRepositoryImpl =
      EquipRepositoryImpl(equipFloorDatasource, equipWebServiceDatasource);
  final listEquip = [
    Equip(idEquip: 1, nroEquip: 100),
  ];
  final listEquipWebServiceModelInput = [
    EquipWebServiceModelInput(idEquip: 1, nroEquip: 100),
  ];
  final listEquipFloorModel = [
    EquipFloorModel(idEquip: 1, nroEquip: 100),
  ];

  group('Test EquipRepositoryImpl', () {
    test('deve retornar true se apagar os dados', () async {
      when(equipFloorDatasource.deleteAllEquip())
          .thenAnswer((_) => Future(() => const Right(true)));
      final result = await equipRepositoryImpl.deleteAllEquip();
      expect(result.fold(id, id), true);
    });

    test('deve retornar false se tiver erro apagar os dados', () async {
      when(equipFloorDatasource.deleteAllEquip())
          .thenAnswer((_) => Future(() => Left(ErrorFloorDatasource("Erro"))));
      final result = await equipRepositoryImpl.deleteAllEquip();
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });

    test('deve retornar o list de Equip do web service', () async {
      when(equipWebServiceDatasource.getAllEquip("12345"))
          .thenAnswer((_) => Future(() => listEquipWebServiceModelInput));
      var result = await equipRepositoryImpl.recoverAllEquip("12345");
      expect(result.isRight(), true);
      expect(result.fold(id, id), listEquip);
    });

    test(
        'deve retornar Falhar de Integração de Dados de pegar dados dos Equiporadores do web service',
        () async {
      when(equipWebServiceDatasource.getAllEquip("12345"))
          .thenThrow("Falha de Integração");
      var result = await equipRepositoryImpl.recoverAllEquip("12345");
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorRepository>());
    });

    test(
        'deve retornar false se tiver erro ao pegar dados dos Equiporadores do web service',
        () async {
      when(equipWebServiceDatasource.getAllEquip("12345"))
          .thenThrow(ErrorWebServiceDatasource("Falha de Erro Conexão"));
      final result = await equipRepositoryImpl.recoverAllEquip("12345");
      expect(result.fold(id, id), isA<ErrorWebServiceDatasource>());
    });

    test('deve retornar true se salvar todos os dados', () async {
      when(equipFloorDatasource.addAllEquip(listEquipFloorModel))
          .thenAnswer((_) => Future(() => const Right(true)));
      final result = await equipRepositoryImpl.addAllEquip(listEquip);
      expect(result.fold(id, id), true);
    });

    test('deve retornar Falhar de Integração de Dados ao salvar todos os dados',
        () async {
      when(equipFloorDatasource.addAllEquip(listEquipFloorModel))
          .thenAnswer((_) => Future(() => Left(ErrorFloorDatasource("Erro"))));
      var result = await equipRepositoryImpl.addAllEquip(listEquip);
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });

    test('deve retornar Falhar de Integração de Dados ao salvar todos os dados',
        () async {
      when(equipFloorDatasource.addAllEquip(listEquipFloorModel))
          .thenAnswer((_) => Future(() => Left(ErrorRepository("Erro"))));
      var result = await equipRepositoryImpl.addAllEquip(listEquip);
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorRepository>());
    });
  });
}
