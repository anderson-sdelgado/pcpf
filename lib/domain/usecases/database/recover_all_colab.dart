import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/stable/colab.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/stable/colab_repository.dart';
import 'package:pcp/domain/repositories/variable/config_repository.dart';
import 'package:pcp/utils/token.dart';

abstract class RecoverAllColab {
  Future<Either<Failure, List<Colab>>> call();
}

class RecoverAllColabImpl implements RecoverAllColab {
  final ColabRepository colabRepository;
  final ConfigRepository configRepository;

  RecoverAllColabImpl(
    this.colabRepository,
    this.configRepository,
  );

  @override
  Future<Either<Failure, List<Colab>>> call() async {
    final numAparelho = await configRepository.getNroAparelho();
    final version = await configRepository.getVersion();
    final tk = token(numAparelho.toString(), version);
    return colabRepository.recoverAllColab(tk);
  }
}
