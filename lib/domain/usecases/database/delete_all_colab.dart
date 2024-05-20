import 'package:dartz/dartz.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/stable/colab_repository.dart';

abstract class DeleteAllColab {
  Future<Either<Failure, bool>> call();
}

class DeleteAllColabImpl implements DeleteAllColab {

  final ColabRepository colabRepository;
  DeleteAllColabImpl(this.colabRepository);

  @override
  Future<Either<Failure, bool>> call() async {
    return await colabRepository.deleteAllColab();
  }

}