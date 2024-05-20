import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/variable/config.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/variable/config_repository.dart';
import 'package:pcp/infra/datasource/shared_preferences/config_shared_preferences_datasource.dart';
import 'package:pcp/infra/datasource/web_preferences/variable/config_web_service_datasource.dart';
import 'package:pcp/infra/model/shared_preferences/config_shared_preferences_model.dart';

import '../../model/web_service/variable/config_web_service_model.dart';

class ConfigRepositoryImpl implements ConfigRepository {
  final ConfigSharedPreferencesDatasource configSharedPreferencesDatasource;
  final ConfigWebServiceDatasource configWebServiceDatasource;

  ConfigRepositoryImpl(
      this.configSharedPreferencesDatasource, this.configWebServiceDatasource);

  @override
  Future<String> getSenha() async {
    return await configSharedPreferencesDatasource
        .getConfig()
        .then((value) => value.passwordConfig!);
  }

  @override
  Future<bool> has() {
    return configSharedPreferencesDatasource.hasConfig();
  }

  @override
  Future<Either<Failure, num>> send(Config config) async {
    try {
      final configWebServiceModel = await configWebServiceDatasource.sendConfig(
          ConfigWebServiceModelOutput.toConfigWebServiceModel(config));
      return Right(int.parse(configWebServiceModel.idBD));
    } on ErrorWebServiceDatasource catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ErrorRepository("sendConfig =>  ${e.toString()}"));
    }
  }

  @override
  Future<void> save(Config config) async {
    return await configSharedPreferencesDatasource.salveConfig(
        ConfigSharedPreferencesModel.toConfigSharedPreferencesModel(config));
  }

  @override
  Future<num> getNroAparelho() async {
    return await configSharedPreferencesDatasource
        .getConfig()
        .then((value) => value.nroAparelhoConfig!);
  }

  @override
  Future<String> getVersion() async {
    return await configSharedPreferencesDatasource
        .getConfig()
        .then((value) => value.version!);
  }
}
