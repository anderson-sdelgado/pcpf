import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/stable/terceiro.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/stable/terceiro_repository.dart';

abstract class AddAllTerceiro {
  Future<Either<Failure, bool>> call(List<Terceiro> list);
}

class AddAllTerceiroImpl implements AddAllTerceiro {

  final TerceiroRepository terceiroRepository;
  AddAllTerceiroImpl(this.terceiroRepository);

  @override
  Future<Either<Failure, bool>> call(List<Terceiro> list) async {
    return await terceiroRepository.addAllTerceiro(list);
  }

}