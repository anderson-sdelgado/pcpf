import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/external/floor/app_database.dart';
import 'package:pcp/external/floor/stable/colab_floor_datasource_impl.dart';
import 'package:pcp/infra/model/floor/stable/colab_floor_model.dart';

main() {
  group('Test ColabFloorDatasourceSharedImpl', () {
    late AppDatabase database;
    final listColabFloorModel = [
      ColabFloorModel(
        matricColab: 19759,
        nomeColab: "Anderson",
      ),
      ColabFloorModel(
        matricColab: 19035,
        nomeColab: "Jose Donizete",
      ),
    ];

    final listColabFloorModelError = [
      ColabFloorModel(
        matricColab: 19759,
        nomeColab: "Anderson",
      ),
      ColabFloorModel(
        matricColab: 19035,
        nomeColab: "Jose Donizete",
      ),
      ColabFloorModel(
        matricColab: 19035,
        nomeColab: "Teste",
      ),
    ];

    setUp(() async {
      database = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    });

    tearDown(() async {
      await database.close();
    });

    test('Testar Apagar todos os dados na tabela', () async {
      final colabFloorDatasourceImpl = ColabFloorDatasourceImpl(database);
      final result = await colabFloorDatasourceImpl.deleteAllColab();
      expect(result.isRight(), true);
      expect(result.fold(id, id), true);
    });

    test('Testar Inserção todos os dados na tabela', () async {
      final colabFloorDatasourceImpl = ColabFloorDatasourceImpl(database);
      final result =
          await colabFloorDatasourceImpl.addAllColab(listColabFloorModel);
      expect(result.isRight(), true);
      expect(result.fold(id, id), true);
    });

    test('Testar Erro de Inserção duplicado', () async {
      final colabFloorDatasourceImpl = ColabFloorDatasourceImpl(database);
      final result =
          await colabFloorDatasourceImpl.addAllColab(listColabFloorModelError);
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });
  });
}
