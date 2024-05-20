import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:pcp/domain/entities/variable/config.dart';

class ConfigWebServiceModelOutput with EquatableMixin {
  final num nroAparelho;
  final String version;

  ConfigWebServiceModelOutput({
    required this.nroAparelho,
    required this.version,
  });

  factory ConfigWebServiceModelOutput.toConfigWebServiceModel(Config config) {
    return ConfigWebServiceModelOutput(
      nroAparelho: config.nroAparelhoConfig!,
      version: config.version!,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nroAparelho': nroAparelho,
      'version': version,
    };
  }

  factory ConfigWebServiceModelOutput.fromMap(Map<String, dynamic> map) {
    return ConfigWebServiceModelOutput(
      nroAparelho: map['nroAparelho'] as num,
      version: map['version'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfigWebServiceModelOutput.fromJson(String source) =>
      ConfigWebServiceModelOutput.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [nroAparelho, version];
}

class ConfigWebServiceModelInput with EquatableMixin {
  final String idBD;

  ConfigWebServiceModelInput({
    required this.idBD,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idBD': idBD,
    };
  }

  factory ConfigWebServiceModelInput.fromMap(Map<String, dynamic> map) {
    return ConfigWebServiceModelInput(
      idBD: map['idBD'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfigWebServiceModelInput.fromJson(String source) =>
      ConfigWebServiceModelInput.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
        idBD,
      ];
}
