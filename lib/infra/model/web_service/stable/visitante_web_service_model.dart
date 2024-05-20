import 'dart:convert';

import 'package:equatable/equatable.dart';

class VisitanteWebServiceModelInput with EquatableMixin {
  final int idVisitante;
  final String cpfVisitante;
  final String nomeVisitante;
  final String empresaVisitante;

  VisitanteWebServiceModelInput({
    required this.idVisitante,
    required this.cpfVisitante,
    required this.nomeVisitante,
    required this.empresaVisitante,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idVisitante': idVisitante,
      'cpfVisitante': cpfVisitante,
      'nomeVisitante': nomeVisitante,
      'empresaVisitante': empresaVisitante,
    };
  }

  factory VisitanteWebServiceModelInput.fromMap(Map<String, dynamic> map) {
    String cpf;
    if(map['cpfVisitante'] is int){
      cpf = map['cpfVisitante'].toString();
    } else {
      cpf = map['cpfVisitante'] as String;
    }

    String nomeEmpresa;
    if(map['empresaVisitante'] is int){
      nomeEmpresa = map['empresaVisitante'].toString();
    } else {
      nomeEmpresa = map['empresaVisitante'] as String;
    }

    return VisitanteWebServiceModelInput(
      idVisitante: map['idVisitante'] as int,
      cpfVisitante: cpf,
      nomeVisitante: map['nomeVisitante'] as String,
      empresaVisitante: nomeEmpresa,
    );
  }

  String toJson() => json.encode(toMap());

  factory VisitanteWebServiceModelInput.fromJson(String source) =>
      VisitanteWebServiceModelInput.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
    idVisitante,
    cpfVisitante,
    nomeVisitante,
    empresaVisitante,
  ];
}
