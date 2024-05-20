import 'package:equatable/equatable.dart';
import 'package:pcp/infra/model/floor/stable/visitante_floor_model.dart';
import 'package:pcp/infra/model/web_service/stable/visitante_web_service_model.dart';

class Visitante with EquatableMixin {
  final int idVisitante;
  final String cpfVisitante;
  final String nomeVisitante;
  final String empresaVisitante;

  Visitante({
    required this.idVisitante,
    required this.cpfVisitante,
    required this.nomeVisitante,
    required this.empresaVisitante,
  });

  factory Visitante.fromFloorModelToEntity(VisitanteFloorModel visitanteRoomModel) {
    return Visitante(
      idVisitante: visitanteRoomModel.idVisitante,
      cpfVisitante: visitanteRoomModel.cpfVisitante,
      nomeVisitante: visitanteRoomModel.nomeVisitante,
      empresaVisitante: visitanteRoomModel.empresaVisitante,
    );
  }


  factory Visitante.fromWebServiceModelToEntity(VisitanteWebServiceModelInput visitanteWebServiceModelInput) {
    return Visitante(
      idVisitante: visitanteWebServiceModelInput.idVisitante,
      cpfVisitante: visitanteWebServiceModelInput.cpfVisitante,
      nomeVisitante: visitanteWebServiceModelInput.nomeVisitante,
      empresaVisitante: visitanteWebServiceModelInput.empresaVisitante,
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
