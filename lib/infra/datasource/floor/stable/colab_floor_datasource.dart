import 'package:dartz/dartz.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/infra/model/floor/stable/colab_floor_model.dart';

abstract class ColabFloorDatasource {
  Future<Either<Failure, bool>> addAllColab(List<ColabFloorModel> list);
  Future<Either<Failure, bool>> deleteAllColab();
}