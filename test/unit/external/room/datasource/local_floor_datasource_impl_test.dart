import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/external/floor/app_database.dart';
import 'package:pcp/external/floor/stable/local_floor_datasource_impl.dart';
import 'package:pcp/infra/model/floor/stable/local_floor_model.dart';

main() {
  group('Test LocalFloorDatasourceSharedImpl', () {
    late AppDatabase database;
    final listLocalFloorModel = [
      LocalFloorModel(
        idLocal: 1,
        descrLocal: "Usina",
      ),
    ];

    final listLocalFloorModelError = [
      LocalFloorModel(
        idLocal: 1,
        descrLocal: "Usina",
      ),
      LocalFloorModel(
        idLocal: 1,
        descrLocal: "Usina",
      ),
    ];

    setUp(() async {
      database = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    });

    tearDown(() async {
      await database.close();
    });

    test('Testar Apagar todos os dados na tabela', () async {
      final localFloorDatasourceImpl = LocalFloorDatasourceImpl(database);
      final result = await localFloorDatasourceImpl.deleteAllLocal();
      expect(result.isRight(), true);
      expect(result.fold(id, id), true);
    });

    test('Testar Inserção todos os dados na tabela', () async {
      final localFloorDatasourceImpl = LocalFloorDatasourceImpl(database);
      final result =
          await localFloorDatasourceImpl.addAllLocal(listLocalFloorModel);
      expect(result.isRight(), true);
      expect(result.fold(id, id), true);
    });

    test('Testar Erro de Inserção duplicado', () async {
      final localFloorDatasourceImpl = LocalFloorDatasourceImpl(database);
      final result =
          await localFloorDatasourceImpl.addAllLocal(listLocalFloorModelError);
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });
  });
}
