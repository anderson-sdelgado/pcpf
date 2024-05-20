import 'dart:convert';

import 'package:equatable/equatable.dart';

class TerceiroWebServiceModelInput with EquatableMixin {
  final int idBDTerceiro;
  final String cpfTerceiro;
  final String nomeTerceiro;
  final String empresaTerceiro;

  TerceiroWebServiceModelInput({
    required this.idBDTerceiro,
    required this.cpfTerceiro,
    required this.nomeTerceiro,
    required this.empresaTerceiro,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idBDTerceiro': idBDTerceiro,
      'cpfTerceiro': cpfTerceiro,
      'nomeTerceiro': nomeTerceiro,
      'empresaTerceiro': empresaTerceiro,
    };
  }

  factory TerceiroWebServiceModelInput.fromMap(Map<String, dynamic> map) {
    return TerceiroWebServiceModelInput(
      idBDTerceiro: map['idBDTerceiro'] as int,
      cpfTerceiro: map['cpfTerceiro'] as String,
      nomeTerceiro: map['nomeTerceiro'] as String,
      empresaTerceiro: map['empresaTerceiro'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TerceiroWebServiceModelInput.fromJson(String source) =>
      TerceiroWebServiceModelInput.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
    idBDTerceiro,
    cpfTerceiro,
    nomeTerceiro,
    empresaTerceiro,
  ];
}
