import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/stable/equip.dart';
import 'package:pcp/domain/errors/errors.dart';

abstract class EquipRepository {
  Future<Either<Failure, bool>> addAllEquip(List<Equip> list);
  Future<Either<Failure, bool>> deleteAllEquip();
  Future<Either<Failure, List<Equip>>> recoverAllEquip(String token);
}