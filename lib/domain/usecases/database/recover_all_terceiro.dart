import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/stable/terceiro.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/stable/terceiro_repository.dart';
import 'package:pcp/domain/repositories/variable/config_repository.dart';
import 'package:pcp/utils/token.dart';

abstract class RecoverAllTerceiro {
  Future<Either<Failure, List<Terceiro>>> call();
}

class RecoverAllTerceiroImpl implements RecoverAllTerceiro {
  final TerceiroRepository terceiroRepository;
  final ConfigRepository configRepository;

  RecoverAllTerceiroImpl(
      this.terceiroRepository,
      this.configRepository,
      );

  @override
  Future<Either<Failure, List<Terceiro>>> call() async {
    final numAparelho = await configRepository.getNroAparelho();
    final version = await configRepository.getVersion();
    final tk = token(numAparelho.toString(), version);
    return terceiroRepository.recoverAllTerceiro(tk);
  }
}