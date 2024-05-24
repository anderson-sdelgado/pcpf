import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:pcp/domain/entities/stable/colab.dart';
import 'package:pcp/utils/constant.dart';

@Entity(tableName: TABLE_FLOOR_COLAB)
class ColabFloorModel extends Equatable {
  @PrimaryKey()
  final int matricColab;
  final String nomeColab;

  const ColabFloorModel({
    required this.matricColab,
    required this.nomeColab,
  });

  factory ColabFloorModel.fromEntityToFloorModel(Colab colab) {
    return ColabFloorModel(
      matricColab: colab.matricColab,
      nomeColab: colab.nomeColab,
    );
  }

  @override
  List<Object?> get props => [
    matricColab,
    nomeColab,
  ];

}
