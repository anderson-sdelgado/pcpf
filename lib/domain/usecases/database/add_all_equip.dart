import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/stable/equip.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/stable/equip_repository.dart';

abstract class AddAllEquip {
  Future<Either<Failure, bool>> call(List<Equip> list);
}

class AddAllEquipImpl implements AddAllEquip {

  final EquipRepository equipRepository;
  AddAllEquipImpl(this.equipRepository);

  @override
  Future<Either<Failure, bool>> call(List<Equip> list) async {
    return await equipRepository.addAllEquip(list);
  }

}