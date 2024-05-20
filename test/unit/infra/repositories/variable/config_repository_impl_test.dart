import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pcp/domain/entities/variable/config.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/infra/model/shared_preferences/config_shared_preferences_model.dart';
import 'package:pcp/infra/model/web_service/variable/config_web_service_model.dart';
import 'package:pcp/infra/repositories/variable/config_repository_impl.dart';

import '../../datasource/mock_datasource.mocks.dart';

main() {
  final configSharedPreferencesDatasource =
      MockConfigSharedPreferencesDatasource();
  final configWebServiceDatasource = MockConfigWebServiceDatasource();
  final confiRepositoryImpl = ConfigRepositoryImpl(
      configSharedPreferencesDatasource, configWebServiceDatasource);

  final config = Config(
    nroAparelhoConfig: 16997417840,
    passwordConfig: "12345",
    version: "1.0",
  );

  group('Test ConfigRepositoryImpl', () {
    test('deve retornar True se tiver dados salvos de Config', () async {
      when(configSharedPreferencesDatasource.hasConfig())
          .thenAnswer((_) => Future(() => true));
      bool result = await confiRepositoryImpl.has();
      expect(result, true);
    });

    test('deve retornar senha do ConfigSharedPreferencesModel', () async {
      var result = ConfigSharedPreferencesModel(passwordConfig: "senha");
      expect(result.passwordConfig, "senha");
    });

    test('deve retornar Senha se tiver dados salvos de Config', () async {
      when(configSharedPreferencesDatasource.getConfig()).thenAnswer((_) =>
          Future(() => ConfigSharedPreferencesModel(passwordConfig: "senha")));
      String result = await confiRepositoryImpl.getSenha();
      expect(result, "senha");
    });

    test('deve retornar o id do web service', () async {
      when(configWebServiceDatasource.sendConfig(
              ConfigWebServiceModelOutput.toConfigWebServiceModel(config)))
          .thenAnswer(
              (_) => Future(() => ConfigWebServiceModelInput(idBD: "1")));
      var result = await confiRepositoryImpl.send(config);
      expect(result.isRight(), true);
      expect(result.fold(id, id), 1);
    });

    test('deve retornar Falhar de Integração de Dados', () async {
      when(configWebServiceDatasource.sendConfig(
              ConfigWebServiceModelOutput.toConfigWebServiceModel(config)))
          .thenThrow("Falha de Integração");
      var result = await confiRepositoryImpl.send(config);
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorRepository>());
    });

    test('deve retornar Falha de Conexão se Falha o acesso ao web service',
        () async {
      when(configWebServiceDatasource.sendConfig(
              ConfigWebServiceModelOutput.toConfigWebServiceModel(config)))
          .thenThrow(ErrorWebServiceDatasource("Falha de Erro Conexão"));
      var result = await confiRepositoryImpl.send(config);
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ErrorWebServiceDatasource>());
    });

    test('execução de salvar config Shared Preferences', () async {
      final config = Config(
        nroAparelhoConfig: 16997417840,
        passwordConfig: "12345",
        version: "1.0",
        idBDConfig: 1,
      );
      when(configSharedPreferencesDatasource.salveConfig(
              ConfigSharedPreferencesModel.toConfigSharedPreferencesModel(
                  config)))
          .thenAnswer((_) async {});
      var result = confiRepositoryImpl.save(config);
      expect(result, completes);
    });

    test('deve retornar Nro do Aparelho se tiver dados salvos de Config',
        () async {
      when(configSharedPreferencesDatasource.getConfig()).thenAnswer((_) =>
          Future(() =>
              ConfigSharedPreferencesModel(nroAparelhoConfig: 16997417840)));
      var result = await confiRepositoryImpl.getNroAparelho();
      expect(result, 16997417840);
    });

    test('deve retornar Nro do Aparelho se tiver dados salvos de Config',
        () async {
      when(configSharedPreferencesDatasource.getConfig()).thenAnswer(
          (_) => Future(() => ConfigSharedPreferencesModel(version: '1.00')));
      var result = await confiRepositoryImpl.getVersion();
      expect(result, '1.00');
    });
  });
}
