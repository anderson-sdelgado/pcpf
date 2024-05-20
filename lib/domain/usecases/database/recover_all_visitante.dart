import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/stable/visitante.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/stable/visitante_repository.dart';
import 'package:pcp/domain/repositories/variable/config_repository.dart';
import 'package:pcp/utils/token.dart';

abstract class RecoverAllVisitante {
  Future<Either<Failure, List<Visitante>>> call();
}

class RecoverAllVisitanteImpl implements RecoverAllVisitante {
  final VisitanteRepository visitanteRepository;
  final ConfigRepository configRepository;

  RecoverAllVisitanteImpl(
      this.visitanteRepository,
      this.configRepository,
      );

  @override
  Future<Either<Failure, List<Visitante>>> call() async {
    final numAparelho = await configRepository.getNroAparelho();
    final version = await configRepository.getVersion();
    final tk = token(numAparelho.toString(), version);
    return visitanteRepository.recoverAllVisitante(tk);
  }
}