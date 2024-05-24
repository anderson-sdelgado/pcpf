import 'package:equatable/equatable.dart';
import 'package:pcp/infra/model/shared_preferences/config_shared_preferences_model.dart';
import 'package:pcp/utils/enum.dart';

class Config with EquatableMixin {
  final num? nroAparelhoConfig;
  final String? passwordConfig;
  final num? idBDConfig;
  final String? version;
  FlagUpdate? flagUpdate;
  num? matricVigia;
  num? idLocal;
  StatusSend? statusEnvio;
  StatusData? statusApont;

  Config({
    this.nroAparelhoConfig,
    this.passwordConfig,
    this.idBDConfig,
    this.version,
    this.flagUpdate = FlagUpdate.OUTDATED,
    this.matricVigia,
    this.idLocal,
    this.statusEnvio = StatusSend.SENT,
    this.statusApont = StatusData.CLOSE,
  });

  factory Config.fromSharedPreferencesModelToEntity(
      ConfigSharedPreferencesModel configSharedPreferencesModel) {
    return Config(
      nroAparelhoConfig: configSharedPreferencesModel.nroAparelhoConfig,
      passwordConfig: configSharedPreferencesModel.passwordConfig,
      idBDConfig: configSharedPreferencesModel.idBDConfig,
      version: configSharedPreferencesModel.version,
      flagUpdate: configSharedPreferencesModel.flagUpdate,
      matricVigia: configSharedPreferencesModel.matricVigia,
      idLocal: configSharedPreferencesModel.idLocal,
      statusEnvio: configSharedPreferencesModel.statusEnvio,
      statusApont: configSharedPreferencesModel.statusApont,
    );
  }

  @override
  List<Object?> get props => [
        nroAparelhoConfig,
        passwordConfig,
        idBDConfig,
        version,
        flagUpdate,
        matricVigia,
        idLocal,
        statusEnvio,
      ];
}
