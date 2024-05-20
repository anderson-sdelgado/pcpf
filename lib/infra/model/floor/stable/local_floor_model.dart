import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:pcp/domain/entities/stable/local.dart';
import 'package:pcp/utils/constant.dart';

@Entity(tableName: TABLE_FLOOR_LOCAL)
class LocalFloorModel extends Equatable {
  @PrimaryKey()
  final int idLocal;
  final String descrLocal;

  LocalFloorModel({
    required this.idLocal,
    required this.descrLocal,
  });

  factory LocalFloorModel.fromEntityToFloorModel(Local local) {
    return LocalFloorModel(
      idLocal: local.idLocal,
      descrLocal: local.descrLocal,
    );
  }

  @override
  List<Object?> get props => [
    idLocal,
    descrLocal,
  ];

}
