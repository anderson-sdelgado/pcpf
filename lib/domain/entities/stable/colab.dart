import 'package:equatable/equatable.dart';
import 'package:pcp/infra/model/floor/stable/colab_floor_model.dart';
import 'package:pcp/infra/model/web_service/stable/colab_web_service_model.dart';

class Colab with EquatableMixin {
  final int matricColab;
  final String nomeColab;

  Colab({
    required this.matricColab,
    required this.nomeColab,
  });

  @override
  List<Object?> get props => [
    matricColab,
    nomeColab,
  ];

  factory Colab.fromFloorModelToEntity(ColabFloorModel colabRoomModel) {
    return Colab(
      matricColab: colabRoomModel.matricColab,
      nomeColab: colabRoomModel.nomeColab,
    );
  }


  factory Colab.fromWebServiceModelToEntity(ColabWebServiceModelInput colabWebServiceModelInput) {
    return Colab(
      matricColab: colabWebServiceModelInput.matricColab,
      nomeColab: colabWebServiceModelInput.nomeColab,
    );
  }
}
