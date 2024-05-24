import 'package:dartz/dartz.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/external/floor/app_database.dart';
import 'package:pcp/infra/datasource/floor/stable/colab_floor_datasource.dart';
import 'package:pcp/infra/model/floor/stable/colab_floor_model.dart';

class ColabFloorDatasourceImpl implements ColabFloorDatasource {
  final AppDatabase appDatabase;
  ColabFloorDatasourceImpl(this.appDatabase);

  @override
  Future<Either<Failure, bool>> deleteAllColab() async {
    try {
      final dao = appDatabase.colabDao;
      await dao.deleteAll();
      return const Right(true);
    } catch (ex) {
      return Left(ErrorFloorDatasource(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> addAllColab(List<ColabFloorModel> list) async {
    try {
      final dao = appDatabase.colabDao;
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
