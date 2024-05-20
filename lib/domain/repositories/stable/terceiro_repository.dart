import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/stable/terceiro.dart';
import 'package:pcp/domain/errors/errors.dart';

abstract class TerceiroRepository {
  Future<Either<Failure, bool>> addAllTerceiro(List<Terceiro> list);
  Future<Either<Failure, bool>> deleteAllTerceiro();
  Future<Either<Failure, List<Terceiro>>> recoverAllTerceiro(String token);
}