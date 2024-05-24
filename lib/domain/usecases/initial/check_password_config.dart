import 'package:pcp/domain/repositories/variable/config_repository.dart';

abstract class CheckPasswordConfig {
  Future<bool> call(String senha);
}

class CheckPasswordConfigImpl implements CheckPasswordConfig {

  final ConfigRepository configRepository;
  CheckPasswordConfigImpl(this.configRepository);

  @override
  Future<bool> call(String senha) async {
    final hasConfig = await configRepository.has();
    if (!hasConfig) return true;
    final senhaConfig = await configRepository.getSenha();
    if (senhaConfig == senha) return true;
    return false;
  }
}
