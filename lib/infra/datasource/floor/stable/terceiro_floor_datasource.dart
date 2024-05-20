import 'package:dartz/dartz.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/infra/model/floor/stable/terceiro_floor_model.dart';

abstract class TerceiroFloorDatasource {
  Future<Either<Failure, bool>> addAllTerceiro(List<TerceiroFloorModel> list);
  Future<Either<Failure, bool>> deleteAllTerceiro();
}