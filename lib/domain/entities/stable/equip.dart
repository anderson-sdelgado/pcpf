import 'package:equatable/equatable.dart';
import 'package:pcp/infra/model/floor/stable/equip_floor_model.dart';
import 'package:pcp/infra/model/web_service/stable/equip_web_service_model.dart';

class Equip with EquatableMixin {
  final int idEquip;
  final int nroEquip;

  Equip({
    required this.idEquip,
    required this.nroEquip,
  });

  factory Equip.fromFloorModelToEntity(EquipFloorModel equipRoomModel) {
    return Equip(
      idEquip: equipRoomModel.idEquip,
      nroEquip: equipRoomModel.nroEquip,
    );
  }


  factory Equip.fromWebServiceModelToEntity(EquipWebServiceModelInput equipWebServiceModelInput) {
    return Equip(
      idEquip: equipWebServiceModelInput.idEquip,
      nroEquip: equipWebServiceModelInput.nroEquip,
    );
  }

  @override
  List<Object?> get props => [
        idEquip,
        nroEquip,
      ];
}
