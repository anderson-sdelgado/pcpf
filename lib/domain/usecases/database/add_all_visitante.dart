import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/stable/visitante.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/stable/visitante_repository.dart';

abstract class AddAllVisitante {
  Future<Either<Failure, bool>> call(List<Visitante> list);
}

class AddAllVisitanteImpl implements AddAllVisitante {

  final VisitanteRepository visitanteRepository;
  AddAllVisitanteImpl(this.visitanteRepository);

  @override
  Future<Either<Failure, bool>> call(List<Visitante> list) async {
    return await visitanteRepository.addAllVisitante(list);
  }

}