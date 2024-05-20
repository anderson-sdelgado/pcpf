import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/variable/config.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/variable/config_repository.dart';

abstract class SendInitialConfig {
  Future<Either<Failure, num>> call({
    required String nroAparelho,
    required String senha,
    required String version,
  });
}

class SendInitialConfigImpl implements SendInitialConfig {
  final ConfigRepository configRepository;

  SendInitialConfigImpl(this.configRepository);

  @override
  Future<Either<Failure, num>> call({
    required String nroAparelho,
    required String senha,
    required String version,
  }) {
    final config = Config(
      nroAparelhoConfig: int.parse(nroAparelho),
      passwordConfig: senha,
      version: version,
    );
    return configRepository.send(config);
  }

}
