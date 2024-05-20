import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/stable/equip.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/stable/equip_repository.dart';
import 'package:pcp/domain/repositories/variable/config_repository.dart';
import 'package:pcp/utils/token.dart';

abstract class RecoverAllEquip {
  Future<Either<Failure, List<Equip>>> call();
}

class RecoverAllEquipImpl implements RecoverAllEquip {
  final EquipRepository equipRepository;
  final ConfigRepository configRepository;

  RecoverAllEquipImpl(
      this.equipRepository,
      this.configRepository,
      );

  @override
  Future<Either<Failure, List<Equip>>> call() async {
    final numAparelho = await configRepository.getNroAparelho();
    final version = await configRepository.getVersion();
    final tk = token(numAparelho.toString(), version);
    return equipRepository.recoverAllEquip(tk);
  }
}