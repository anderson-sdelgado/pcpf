import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/stable/colab.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/stable/colab_repository.dart';
import 'package:pcp/infra/datasource/floor/stable/colab_floor_datasource.dart';
import 'package:pcp/infra/datasource/web_preferences/stable/colab_web_service_datasource.dart';
import 'package:pcp/infra/model/floor/stable/colab_floor_model.dart';

class ColabRepositoryImpl implements ColabRepository {
  ColabFloorDatasource colabFloorDatasource;
  ColabWebServiceDatasource colabWebServiceDatasource;

  ColabRepositoryImpl(
      this.colabFloorDatasource, this.colabWebServiceDatasource);

  @override
  Future<Either<Failure, bool>> deleteAllColab() async {
    return await colabFloorDatasource.deleteAllColab();
  }

  @override
  Future<Either<Failure, List<Colab>>> recoverAllColab(String token) async {
    try {
      final result = await colabWebServiceDatasource.getAllColab(token);
      return Right(
          result.map((e) => Colab.fromWebServiceModelToEntity(e)).toList());
    } on ErrorWebServiceDatasource catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ErrorRepository("recoverAllColab =>  ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, bool>> addAllColab(List<Colab> list) async {
    try {
      return await colabFloorDatasource.addAllColab(list.map((e) => ColabFloorModel.fromEntityToFloorModel(e)).toList());
    } on ErrorFloorDatasource catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ErrorRepository("addAllColab =>  ${e.toString()}"));
    }
  }
}
