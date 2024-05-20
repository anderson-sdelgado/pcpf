import 'package:equatable/equatable.dart';
import 'package:pcp/infra/model/floor/stable/terceiro_floor_model.dart';
import 'package:pcp/infra/model/web_service/stable/terceiro_web_service_model.dart';

class Terceiro with EquatableMixin {
  final int? idTerceiro;
  final int idBDTerceiro;
  final String cpfTerceiro;
  final String nomeTerceiro;
  final String empresaTerceiro;

  Terceiro({
    required this.idTerceiro,
    required this.idBDTerceiro,
    required this.cpfTerceiro,
    required this.nomeTerceiro,
    required this.empresaTerceiro,
  });

  factory Terceiro.fromFloorModelToEntity(
      TerceiroFloorModel terceiroRoomModel) {
    return Terceiro(
      idTerceiro: terceiroRoomModel.idTerceiro,
      idBDTerceiro: terceiroRoomModel.idBDTerceiro,
      cpfTerceiro: terceiroRoomModel.cpfTerceiro,
      nomeTerceiro: terceiroRoomModel.nomeTerceiro,
      empresaTerceiro: terceiroRoomModel.empresaTerceiro,
    );
  }

  factory Terceiro.fromWebServiceModelToEntity(
      TerceiroWebServiceModelInput terceiroWebServiceModelInput) {
    return Terceiro(
      idTerceiro: null,
      idBDTerceiro: terceiroWebServiceModelInput.idBDTerceiro,
      cpfTerceiro: terceiroWebServiceModelInput.cpfTerceiro,
      nomeTerceiro: terceiroWebServiceModelInput.nomeTerceiro,
      empresaTerceiro: terceiroWebServiceModelInput.empresaTerceiro,
    );
  }

  @override
  List<Object?> get props => [
        idTerceiro,
        idBDTerceiro,
        cpfTerceiro,
        nomeTerceiro,
        empresaTerceiro,
      ];
}
