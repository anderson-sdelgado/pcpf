import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/external/floor/app_database.dart';
import 'package:pcp/external/floor/stable/visitante_floor_datasource_impl.dart';
import 'package:pcp/infra/model/floor/stable/visitante_floor_model.dart';

main() {
  group('Test VisitanteFloorDatasourceSharedImpl', () {
    late AppDatabase database;
    final listVisitanteFloorModel = [
      VisitanteFloorModel(
        idVisitante: 1,
        cpfVisitante: "123.456.789-00",
        nomeVisitante: "Teste",
        empresaVisitante: "Visitante Empresa",
      ),
    ];

    final listVisitanteFloorModelError = [
      VisitanteFloorModel(
        idVisitante: 1,
        cpfVisitante: "123.456.789-00",
        nomeVisitante: "Teste",
        empresaVisitante: "Visitante Empresa",
      ),
      VisitanteFloorModel(
        idVisitante: 1,
        cpfVisitante: "123.456.789-00",
        nomeVisitante: "Teste",
        empresaVisitante: "Visitante Empresa",
      ),
    ];

    setUp(() async {
      database = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    });

    tearDown(() async {
      await database.close();
    });

    test('Testar Apagar todos os dados na tabela', () async {
      final visitanteFloorDatasourceImpl = VisitanteFloorDatasourceImpl(database);
      final result = await visitanteFloorDatasourceImpl.deleteAllVisitante();
      expect(result.isRight(), true);
      expect(result.fold(id, id), true);
    });

    test('Testar Inserção todos os dados na tabela', () async {
      final visitanteFloorDatasourceImpl = VisitanteFloorDatasourceImpl(database);
      final result =
          await visitanteFloorDatasourceImpl.addAllVisitante(listVisitanteFloorModel);
      expect(result.isRight(), true);
      expect(result.fold(id, id), true);
    });

    test('Testar Erro de Inserção duplicado', () async {
      final visitanteFloorDatasourceImpl = VisitanteFloorDatasourceImpl(database);
      final result =
          await visitanteFloorDatasourceImpl.addAllVisitante(listVisitanteFloorModelError);
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorFloorDatasource>());
    });
  });
}
