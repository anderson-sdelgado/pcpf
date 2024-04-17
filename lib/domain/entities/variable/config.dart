// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pcp/utils/enum.dart';

class Config {
  final num? nroAparelhoConfig;
  final String? passwordConfig;
  final num? idBDConfig;
  final String? version;
  final FlagUpdate? flagUpdate;
  final num? matricVigia;
  final num? idLocal;
  final StatusSend? statusEnvio;

  Config({
    this.nroAparelhoConfig,
    this.passwordConfig,
    this.idBDConfig,
    this.version,
    this.flagUpdate = FlagUpdate.OUTDATED,
    this.matricVigia,
    this.idLocal,
    this.statusEnvio = StatusSend.SENT,
  });

  @override
  bool operator ==(covariant Config other) {
    if (identical(this, other)) return true;

    return other.nroAparelhoConfig == nroAparelhoConfig &&
        other.passwordConfig == passwordConfig &&
        other.idBDConfig == idBDConfig &&
        other.version == version &&
        other.flagUpdate == flagUpdate &&
        other.matricVigia == matricVigia &&
        other.idLocal == idLocal &&
        other.statusEnvio == statusEnvio;
  }

  @override
  int get hashCode {
    return nroAparelhoConfig.hashCode ^
        passwordConfig.hashCode ^
        idBDConfig.hashCode ^
        version.hashCode ^
        flagUpdate.hashCode ^
        matricVigia.hashCode ^
        idLocal.hashCode ^
        statusEnvio.hashCode;
  }
}
