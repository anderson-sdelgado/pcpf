import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/external/floor/app_database.dart';
import 'package:pcp/external/floor/stable/terceiro_floor_datasource_impl.dart';
import 'package:pcp/infra/model/floor/stable/terceiro_floor_model.dart';

main() {
  group('Test TerceiroFloorDatasourceSharedImpl', () {
    late AppDatabase database;
    final listTerceiroFloorModel = [
      TerceiroFloorModel(
        idTerceiro: 1,
        idBDTerceiro: 1,
        cpfTerceiro: "123.456.789-00",
        nomeTerceiro: "Teste",
        empresaTerceiro: "Terceiro Empresa",
      ),
    ];

    final listTerceiroFloorModelError = [
      TerceiroFloorModel(
        idTerceiro: 1,
        idBDTerceiro: 1,
        cpfTerceiro: "123.456.789-00",
        nomeTerceiro: "Teste",
        empresaTerceiro: "Terceiro Empresa",
      ),
      TerceiroFloorModel(
        idTerceiro: 1,
        idBDTerceiro: 1,
        cpfTerceiro: "123.456.789-00",
        nomeTerceiro: "Teste",
        empresaTerceiro: "Terceiro Empresa",
      ),
    ];

    setUp(() async {
      database = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    });

    tearDown(() async {
      await database.close();
    });

    test('Testar Apagar todos os dados na tabela', () async {
      final terceiroFloorDatasourceImpl = TerceiroFloorDatasourceImpl(database);
      final result = await terceiroFloorDatasourceImpl.deleteAllTerceiro();
      expect(result.isRight(), true);
      expect(result.fold(id, id), true);
    });

    test('Testar Inserção todos os dados na tabela', () async {
      final terceiroFloorDatasourceImpl = TerceiroFloorDatasourceImpl(database);
      final result =
          await terceiroFloorDatasourceImpl.addAllTerceiro(listTerceiroFloorModel);
      expect(result.isRight(), true);
      expect(result.fold(id, id), true);
    });

    test('Testar Erro de Inserção duplicado', () async {
      final terceiroFloorDatasourceImpl = TerceiroFloorDatasourceImpl(database);
      final result =
          await terceiroFloorDatasourceImpl.addAllTerceiro(listTerceiroFloorModelError);
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });
  });
}
