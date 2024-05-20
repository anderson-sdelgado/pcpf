import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:pcp/utils/enum.dart';

class Config with EquatableMixin {
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
    this.flagUpdate,
    this.matricVigia,
    this.idLocal,
    this.statusEnvio,
  });

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
