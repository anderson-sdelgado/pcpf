import 'package:dartz/dartz.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/stable/local_repository.dart';

abstract class DeleteAllLocal {
  Future<Either<Failure, bool>> call();
}

class DeleteAllLocalImpl implements DeleteAllLocal {

  final LocalRepository localRepository;
  DeleteAllLocalImpl(this.localRepository);

  @override
  Future<Either<Failure, bool>> call() async {
    return await localRepository.deleteAllLocal();
  }

}