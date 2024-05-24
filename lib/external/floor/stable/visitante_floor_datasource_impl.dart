import 'package:dartz/dartz.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/external/floor/app_database.dart';
import 'package:pcp/infra/datasource/floor/stable/visitante_floor_datasource.dart';
import 'package:pcp/infra/model/floor/stable/visitante_floor_model.dart';

class VisitanteFloorDatasourceImpl implements VisitanteFloorDatasource {
  final AppDatabase appDatabase;
  VisitanteFloorDatasourceImpl(this.appDatabase);

  @override
  Future<Either<Failure, bool>> deleteAllVisitante() async {
    try {
      final dao = appDatabase.visitanteDao;
      await dao.deleteAll();
      return const Right(true);
    } catch (ex) {
      return Left(ErrorFloorDatasource(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> addAllVisitante(
      List<VisitanteFloorModel> list) async {
    try {
      final dao = appDatabase.visitanteDao;
      var result = await dao.insertAll(list);
      if (list.length == result.length) {
        return const Right(true);
      } else {
        return Left(ErrorFloorDatasource("Invalid insert count"));
      }
    } catch (ex) {
      return Left(ErrorFloorDatasource(ex.toString()));
    }
  }
}
