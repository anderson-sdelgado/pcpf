import 'package:dartz/dartz.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/infra/model/floor/stable/visitante_floor_model.dart';

abstract class VisitanteFloorDatasource {
  Future<Either<Failure, bool>> addAllVisitante(List<VisitanteFloorModel> list);
  Future<Either<Failure, bool>> deleteAllVisitante();
}