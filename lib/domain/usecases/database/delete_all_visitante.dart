import 'package:dartz/dartz.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/stable/visitante_repository.dart';

abstract class DeleteAllVisitante {
  Future<Either<Failure, bool>> call();
}

class DeleteAllVisitanteImpl implements DeleteAllVisitante {

  final VisitanteRepository visitanteRepository;
  DeleteAllVisitanteImpl(this.visitanteRepository);

  @override
  Future<Either<Failure, bool>> call() async {
    return await visitanteRepository.deleteAllVisitante();
  }

}