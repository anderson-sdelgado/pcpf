import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:pcp/domain/entities/stable/equip.dart';
import 'package:pcp/utils/constant.dart';

@Entity(tableName: TABLE_FLOOR_EQUIP)
class EquipFloorModel extends Equatable {
  @PrimaryKey()
  final int idEquip;
  final int nroEquip;

  const EquipFloorModel({
    required this.idEquip,
    required this.nroEquip,
  });

  factory EquipFloorModel.fromEntityToFloorModel(Equip equip) {
    return EquipFloorModel(
      idEquip: equip.idEquip,
      nroEquip: equip.nroEquip,
    );
  }

  @override
  List<Object?> get props => [
    idEquip,
    nroEquip,
  ];

}
