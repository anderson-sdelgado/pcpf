// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:pcp/domain/entities/variable/config.dart';
import 'package:pcp/utils/enum.dart';

class ConfigSharedPreferencesModel extends Config {
  final num? nroAparelhoConfig;
  final String? passwordConfig;
  final num? idBDConfig;
  final String? version;
  final FlagUpdate? flagUpdate;
  final num? matricVigia;
  final num? idLocal;
  final StatusSend? statusEnvio;

  ConfigSharedPreferencesModel({
    this.nroAparelhoConfig,
    this.passwordConfig,
    this.idBDConfig,
    this.version,
    this.flagUpdate,
    this.matricVigia,
    this.idLocal,
    this.statusEnvio,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nroAparelhoConfig': nroAparelhoConfig,
      'passwordConfig': passwordConfig,
      'idBDConfig': idBDConfig,
      'version': version,
      'flagUpdate': flagUpdate?.index,
      'matricVigia': matricVigia,
      'idLocal': idLocal,
      'statusEnvio': statusEnvio?.index,
    };
  }

  factory ConfigSharedPreferencesModel.fromMap(Map<String, dynamic> map) {
    return ConfigSharedPreferencesModel(
      nroAparelhoConfig: map['nroAparelhoConfig'] != null
          ? map['nroAparelhoConfig'] as num
          : null,
      passwordConfig: map['passwordConfig'] != null
          ? map['passwordConfig'] as String
          : null,
      idBDConfig: map['idBDConfig'] != null ? map['idBDConfig'] as num : null,
      version: map['version'] != null ? map['version'] as String : null,
      flagUpdate: map['flagUpdate'] != null
          ? FlagUpdate.values[map['flagUpdate'] as int]
          : null,
      matricVigia:
          map['matricVigia'] != null ? map['matricVigia'] as num : null,
      idLocal: map['idLocal'] != null ? map['idLocal'] as num : null,
      statusEnvio: map['statusEnvio'] != null
          ? StatusSend.values[map['statusEnvio'] as int]
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfigSharedPreferencesModel.fromJson(String source) =>
      ConfigSharedPreferencesModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}