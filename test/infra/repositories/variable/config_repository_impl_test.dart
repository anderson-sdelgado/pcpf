import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/infra/datasource/shared_preferences/config_datasource_shared_preferences.dart';
import 'package:pcp/infra/model/shared_preferences/config_shared_preferences_model.dart';
import 'package:pcp/infra/repositories/variable/config_repository_impl.dart';

import 'config_repository_impl_test.mocks.dart';

@GenerateMocks([ConfigDatasourceSharedPreferences])
main() {

  final configDatasourceSharedPreferences = MockConfigDatasourceSharedPreferences();
  final confiRepositoryImpl = ConfigRepositoryImpl(configDatasourceSharedPreferences);

  group('Test ConfigRepositoryImpl', () {

    test('deve retornar True se tiver dados salvos de Config', () async {
      when(configDatasourceSharedPreferences.hasConfig()).thenAnswer((_) => Future(() => true));
      bool result = await confiRepositoryImpl.hasConfig();
      expect(result, true);
    });

    test('deve retorno de dados ConfigSharedPreferencesModel', () async {
      var result = ConfigSharedPreferencesModel(passwordConfig: "senha");
      expect(result.passwordConfig, "senha");
    });

    test('deve retornar Senha se tiver dados salvos de Config', () async {
      when(configDatasourceSharedPreferences.getConfig()).thenAnswer((_) => Future(() => ConfigSharedPreferencesModel(passwordConfig: "senha")));
      String result = await confiRepositoryImpl.getSenhaConfig();
      expect(result, "senha");
    });

  });

}