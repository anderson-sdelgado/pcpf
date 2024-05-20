import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/stable/local.dart';
import 'package:pcp/domain/errors/errors.dart';

abstract class LocalRepository {
  Future<Either<Failure, bool>> addAllLocal(List<Local> list);
  Future<Either<Failure, bool>> deleteAllLocal();
  Future<Either<Failure, List<Local>>> recoverAllLocal(String token);
}