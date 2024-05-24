import 'package:pcp/domain/repositories/variable/config_repository.dart';
import 'package:pcp/utils/enum.dart';

abstract class CheckStatusUpdateDatabase {
  Future<bool> call();
}

class CheckStatusUpdateDatabaseImpl implements CheckStatusUpdateDatabase {
  final ConfigRepository configRepository;

  CheckStatusUpdateDatabaseImpl(this.configRepository);

  @override
  Future<bool> call() async {
    final hasConfig = await configRepository.has();
    if (!hasConfig) return false;
    final flagUpdate = await configRepository.getFlagUpdate();
    if (flagUpdate == FlagUpdate.OUTDATED) return false;
    return true;
  }
}
