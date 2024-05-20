import 'package:dartz/dartz.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/infra/model/floor/stable/equip_floor_model.dart';

abstract class EquipFloorDatasource {
  Future<Either<Failure, bool>> addAllEquip(List<EquipFloorModel> list);
  Future<Either<Failure, bool>> deleteAllEquip();
}