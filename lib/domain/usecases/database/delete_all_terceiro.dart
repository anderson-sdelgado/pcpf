import 'package:dartz/dartz.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/stable/terceiro_repository.dart';

abstract class DeleteAllTerceiro {
  Future<Either<Failure, bool>> call();
}

class DeleteAllTerceiroImpl implements DeleteAllTerceiro {

  final TerceiroRepository terceiroRepository;
  DeleteAllTerceiroImpl(this.terceiroRepository);

  @override
  Future<Either<Failure, bool>> call() async {
    return await terceiroRepository.deleteAllTerceiro();
  }

}