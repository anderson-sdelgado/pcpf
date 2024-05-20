import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/external/floor/app_database.dart';
import 'package:pcp/external/floor/stable/equip_floor_datasource_impl.dart';
import 'package:pcp/infra/model/floor/stable/equip_floor_model.dart';

main() {
  group('Test EquipFloorDatasourceSharedImpl', () {
    late AppDatabase database;
    final listEquipFloorModel = [
      EquipFloorModel(
        idEquip: 1,
        nroEquip: 100,
      ),
    ];

    final listEquipFloorModelError = [
      EquipFloorModel(
        idEquip: 1,
        nroEquip: 100,
      ),
      EquipFloorModel(
        idEquip: 1,
        nroEquip: 200,
      ),
    ];

    setUp(() async {
      database = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    });

    tearDown(() async {
      await database.close();
    });

    test('Testar Apagar todos os dados na tabela', () async {
      final equipFloorDatasourceImpl = EquipFloorDatasourceImpl(database);
      final result = await equipFloorDatasourceImpl.deleteAllEquip();
      expect(result.isRight(), true);
      expect(result.fold(id, id), true);
    });

    test('Testar Inserção todos os dados na tabela', () async {
      final equipFloorDatasourceImpl = EquipFloorDatasourceImpl(database);
      final result =
          await equipFloorDatasourceImpl.addAllEquip(listEquipFloorModel);
      expect(result.isRight(), true);
      expect(result.fold(id, id), true);
    });

    test('Testar Erro de Inserção duplicado', () async {
      final equipFloorDatasourceImpl = EquipFloorDatasourceImpl(database);
      final result =
          await equipFloorDatasourceImpl.addAllEquip(listEquipFloorModelError);
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });
  });
}
