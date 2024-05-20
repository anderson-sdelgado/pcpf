import 'package:dartz/dartz.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/infra/model/floor/stable/local_floor_model.dart';

abstract class LocalFloorDatasource {
  Future<Either<Failure, bool>> addAllLocal(List<LocalFloorModel> list);
  Future<Either<Failure, bool>> deleteAllLocal();
}