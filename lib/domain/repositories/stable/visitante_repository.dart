import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/stable/visitante.dart';
import 'package:pcp/domain/errors/errors.dart';

abstract class VisitanteRepository {
  Future<Either<Failure, bool>> addAllVisitante(List<Visitante> list);
  Future<Either<Failure, bool>> deleteAllVisitante();
  Future<Either<Failure, List<Visitante>>> recoverAllVisitante(String token);
}