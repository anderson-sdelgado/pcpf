import 'dart:convert';

import 'package:equatable/equatable.dart';

class LocalWebServiceModelInput with EquatableMixin {
  final int idLocal;
  final String descrLocal;

  LocalWebServiceModelInput({
    required this.idLocal,
    required this.descrLocal,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idLocal': idLocal,
      'descrLocal': descrLocal,
    };
  }

  factory LocalWebServiceModelInput.fromMap(Map<String, dynamic> map) {
    return LocalWebServiceModelInput(
      idLocal: map['idLocal'] as int,
      descrLocal: map['descrLocal'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalWebServiceModelInput.fromJson(String source) =>
      LocalWebServiceModelInput.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
    idLocal,
    descrLocal,
  ];
}
