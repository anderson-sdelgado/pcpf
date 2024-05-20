import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/stable/local.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/stable/local_repository.dart';

abstract class AddAllLocal {
  Future<Either<Failure, bool>> call(List<Local> list);
}

class AddAllLocalImpl implements AddAllLocal {

  final LocalRepository localRepository;
  AddAllLocalImpl(this.localRepository);

  @override
  Future<Either<Failure, bool>> call(List<Local> list) async {
    return await localRepository.addAllLocal(list);
  }

}