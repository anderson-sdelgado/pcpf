import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/stable/local.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/stable/local_repository.dart';
import 'package:pcp/domain/repositories/variable/config_repository.dart';
import 'package:pcp/utils/token.dart';

abstract class RecoverAllLocal {
  Future<Either<Failure, List<Local>>> call();
}

class RecoverAllLocalImpl implements RecoverAllLocal {
  final LocalRepository localRepository;
  final ConfigRepository configRepository;

  RecoverAllLocalImpl(
      this.localRepository,
      this.configRepository,
      );

  @override
  Future<Either<Failure, List<Local>>> call() async {
    final numAparelho = await configRepository.getNroAparelho();
    final version = await configRepository.getVersion();
    final tk = token(numAparelho.toString(), version);
    return localRepository.recoverAllLocal(tk);
  }
}