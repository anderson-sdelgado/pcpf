
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:pcp/domain/entities/stable/visitante.dart';
import 'package:pcp/utils/constant.dart';

@Entity(tableName: TABLE_FLOOR_VISITANTE)
class VisitanteFloorModel extends Equatable {
  @PrimaryKey()
  final int idVisitante;
  final String cpfVisitante;
  final String nomeVisitante;
  final String empresaVisitante;

  VisitanteFloorModel({
    required this.idVisitante,
    required this.cpfVisitante,
    required this.nomeVisitante,
    required this.empresaVisitante,
  });

  factory VisitanteFloorModel.fromEntityToFloorModel(Visitante visitante) {
    return VisitanteFloorModel(
      idVisitante: visitante.idVisitante,
      cpfVisitante: visitante.cpfVisitante,
      nomeVisitante: visitante.nomeVisitante,
      empresaVisitante: visitante.empresaVisitante,
    );
  }

  @override
  List<Object?> get props => [
    idVisitante,
    cpfVisitante,
    nomeVisitante,
    empresaVisitante,
  ];

}
