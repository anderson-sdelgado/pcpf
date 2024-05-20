import 'package:pcp/domain/entities/variable/config.dart';
import 'package:pcp/domain/repositories/variable/config_repository.dart';

abstract class SaveInitialConfig {
  Future<void> call({
    required String nroAparelho,
    required String senha,
    required String version,
    required num idDB,
  });
}

class SaveInitialConfigImpl implements SaveInitialConfig {
  final ConfigRepository configRepository;

  SaveInitialConfigImpl(this.configRepository);

  @override
  Future<void> call({
    required String nroAparelho,
    required String senha,
    required String version,
    required num idDB,
  }) async {
    final config = Config(
      nroAparelhoConfig: int.parse(nroAparelho),
      passwordConfig: senha,
      version: version,
      idBDConfig: idDB,
    );
    return await configRepository.save(config);
  }
}
