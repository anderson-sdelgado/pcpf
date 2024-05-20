
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ColabWebServiceModelInput with EquatableMixin {
  final int matricColab;
  final String nomeColab;

  ColabWebServiceModelInput({
    required this.matricColab,
    required this.nomeColab,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'matricColab': matricColab,
      'nomeColab': nomeColab,
    };
  }

  factory ColabWebServiceModelInput.fromMap(Map<String, dynamic> map) {
    return ColabWebServiceModelInput(
      matricColab: map['matricColab'] as int,
      nomeColab: map['nomeColab'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ColabWebServiceModelInput.fromJson(String source) =>
      ColabWebServiceModelInput.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
    matricColab,
    nomeColab,
  ];
}
