import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:pcp/domain/entities/stable/terceiro.dart';
import 'package:pcp/utils/constant.dart';

@Entity(tableName: TABLE_FLOOR_TERCEIRO)
class TerceiroFloorModel extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? idTerceiro;
  final int idBDTerceiro;
  final String cpfTerceiro;
  final String nomeTerceiro;
  final String empresaTerceiro;

  TerceiroFloorModel({
    required this.idTerceiro,
    required this.idBDTerceiro,
    required this.cpfTerceiro,
    required this.nomeTerceiro,
    required this.empresaTerceiro,
  });

  factory TerceiroFloorModel.fromEntityToFloorModel(Terceiro terceiro) {
    return TerceiroFloorModel(
      idTerceiro: terceiro.idTerceiro,
      idBDTerceiro: terceiro.idBDTerceiro,
      cpfTerceiro: terceiro.cpfTerceiro,
      nomeTerceiro: terceiro.nomeTerceiro,
      empresaTerceiro: terceiro.empresaTerceiro,
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
