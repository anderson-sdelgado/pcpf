import 'package:equatable/equatable.dart';
import 'package:pcp/infra/model/floor/stable/local_floor_model.dart';
import 'package:pcp/infra/model/web_service/stable/local_web_service_model.dart';

class Local with EquatableMixin {
  final int idLocal;
  final String descrLocal;

  Local({
    required this.idLocal,
    required this.descrLocal,
  });

  factory Local.fromFloorModelToEntity(LocalFloorModel localRoomModel) {
    return Local(
      idLocal: localRoomModel.idLocal,
      descrLocal: localRoomModel.descrLocal,
    );
  }


  factory Local.fromWebServiceModelToEntity(LocalWebServiceModelInput localWebServiceModelInput) {
    return Local(
      idLocal: localWebServiceModelInput.idLocal,
      descrLocal: localWebServiceModelInput.descrLocal,
    );
  }

  @override
  List<Object?> get props => [
    idLocal,
    descrLocal,
  ];
}
