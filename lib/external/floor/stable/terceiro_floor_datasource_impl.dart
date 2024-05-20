import 'package:dartz/dartz.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/external/floor/app_database.dart';
import 'package:pcp/external/floor/dao/terceiro_dao.dart';
import 'package:pcp/infra/datasource/floor/stable/terceiro_floor_datasource.dart';
import 'package:pcp/infra/model/floor/stable/terceiro_floor_model.dart';

class TerceiroFloorDatasourceImpl implements TerceiroFloorDatasource {

  final AppDatabase appDatabase;
  TerceiroFloorDatasourceImpl(this.appDatabase);

  @override
  Future<Either<Failure, bool>> deleteAllTerceiro() async {
    try {
      final dao = appDatabase.terceiroDao;
      await dao.deleteAll();
      return const Right(true);
    } catch(ex) {
      return Left(ErrorFloorDatasource(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> addAllTerceiro(List<TerceiroFloorModel> list) async {
    try {
      final dao = appDatabase.terceiroDao;
      var result = await dao.insertAll(list);
      if(list.length == result.length){
        return const Right(true);
      } else {
        return Left(ErrorFloorDatasource("Invalid insert count"));
      }
    } catch(ex) {
      return Left(ErrorFloorDatasource(ex.toString()));
    }
  }

}