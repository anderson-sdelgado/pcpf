import 'package:dartz/dartz.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/stable/equip_repository.dart';

abstract class DeleteAllEquip {
  Future<Either<Failure, bool>> call();
}

class DeleteAllEquipImpl implements DeleteAllEquip {

  final EquipRepository equipRepository;
  DeleteAllEquipImpl(this.equipRepository);

  @override
  Future<Either<Failure, bool>> call() async {
    return await equipRepository.deleteAllEquip();
  }

}