import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/variable/config.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/variable/config_repository.dart';

abstract class SendInitialConfig {
  Future<Either<Failure, num>> call(
    String nroAparelho,
    String senha,
    String version,
  );
}


class SendInitialConfigImpl implements SendInitialConfig {
  final ConfigRepository configRepository;

  SendInitialConfigImpl(this.configRepository);

  @override
  Future<Either<Failure, num>> call(
    String nroAparelho,
    String senha,
    String version,
  ) async {
    final config = Config(
      nroAparelhoConfig: int.parse(nroAparelho),
      passwordConfig: senha,
      version: version,
    );
    return configRepository.sendConfig(config);
  }
}
