import 'package:pcp/domain/repositories/variable/config_repository.dart';
import 'package:pcp/utils/enum.dart';

abstract class SetConfigAllDatabaseUpdate {
  Future<void> call();
}

class SetConfigAllDatabaseUpdateImpl implements SetConfigAllDatabaseUpdate {
  final ConfigRepository configRepository;

  SetConfigAllDatabaseUpdateImpl(this.configRepository);

  @override
  Future<void> call() async {
    final config = await configRepository.getConfig();
    config.flagUpdate = FlagUpdate.UPDATED;
    configRepository.save(config);
  }

}