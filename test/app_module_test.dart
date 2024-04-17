import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/domain/repositories/variable/config_repository.dart';
import 'package:pcp/domain/usecases/initial/check_password_config.dart';
import 'package:pcp/external/shared_preferences/config_datasource_shared_preferences_impl.dart';
import 'package:pcp/infra/datasource/shared_preferences/config_datasource_shared_preferences.dart';
import 'package:pcp/infra/repositories/variable/config_repository_impl.dart';

void main(){

  group('Test usecase module', () {

    Modular.init(AppModule());

    test("Checar o retorno do da class Impl do usecase CheckPasswordConfig", () async {
      final usecase = Modular.get<CheckPasswordConfig>();
      expect(usecase, isA<CheckPasswordConfigImpl>());
    });

  });

  group('Test Repository Module', () {

    Modular.init(AppModule());

    test("Checar o retorno do da class Impl do repository ConfigRepository", () async {
      final repository = Modular.get<ConfigRepository>();
      expect(repository, isA<ConfigRepositoryImpl>());
    });

  });

  group('Test Datasource Module', () {

    Modular.init(AppModule());

    test("Checar o retorno do da class Impl do datasource ConfigDatasourceSharedPreferences", () async {
      final datasource = Modular.get<ConfigDatasourceSharedPreferences>();
      expect(datasource, isA<ConfigDatasourceSharedPreferencesImpl>());
    });

  });
}