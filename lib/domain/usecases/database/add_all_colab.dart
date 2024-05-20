import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/stable/colab.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/stable/colab_repository.dart';

abstract class AddAllColab {
  Future<Either<Failure, bool>> call(List<Colab> list);
}

class AddAllColabImpl implements AddAllColab {

  final ColabRepository colabRepository;
  AddAllColabImpl(this.colabRepository);

  @override
  Future<Either<Failure, bool>> call(List<Colab> list) async {
    return await colabRepository.addAllColab(list);
  }

}