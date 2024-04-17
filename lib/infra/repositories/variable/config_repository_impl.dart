import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/variable/config.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/variable/config_repository.dart';
import 'package:pcp/infra/datasource/shared_preferences/config_datasource_shared_preferences.dart';

class ConfigRepositoryImpl implements ConfigRepository {

  final ConfigDatasourceSharedPreferences configDatasourceSharedPreferences;
  ConfigRepositoryImpl(this.configDatasourceSharedPreferences);

  @override
  Future<String> getSenhaConfig() async {
    return await configDatasourceSharedPreferences.getConfig().then((value) => value.passwordConfig!);
  }

  @override
  Future<bool> hasConfig() {
    return configDatasourceSharedPreferences.hasConfig();
  }

  @override
  Future<Either<Failure, num>> sendConfig(Config config) {
    throw UnimplementedError();
  }

}