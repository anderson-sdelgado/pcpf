import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/stable/colab.dart';
import 'package:pcp/domain/errors/errors.dart';

abstract class ColabRepository {
  Future<Either<Failure, bool>> addAllColab(List<Colab> list);
  Future<Either<Failure, bool>> deleteAllColab();
  Future<Either<Failure, List<Colab>>> recoverAllColab(String token);
}