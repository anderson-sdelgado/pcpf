import 'dart:convert';

import 'package:equatable/equatable.dart';

class EquipWebServiceModelInput with EquatableMixin {
  final int idEquip;
  final int nroEquip;

  EquipWebServiceModelInput({
    required this.idEquip,
    required this.nroEquip,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idEquip': idEquip,
      'nroEquip': nroEquip,
    };
  }

  factory EquipWebServiceModelInput.fromMap(Map<String, dynamic> map) {
    return EquipWebServiceModelInput(
      idEquip: map['idEquip'] as int,
      nroEquip: map['nroEquip'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory EquipWebServiceModelInput.fromJson(String source) =>
      EquipWebServiceModelInput.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
    idEquip,
    nroEquip,
  ];
}
