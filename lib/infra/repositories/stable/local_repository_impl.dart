import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/stable/local.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/stable/local_repository.dart';
import 'package:pcp/infra/datasource/floor/stable/local_floor_datasource.dart';
import 'package:pcp/infra/datasource/web_preferences/stable/local_web_service_datasource.dart';
import 'package:pcp/infra/model/floor/stable/local_floor_model.dart';

class LocalRepositoryImpl implements LocalRepository {
  LocalFloorDatasource localFloorDatasource;
  LocalWebServiceDatasource localWebServiceDatasource;

  LocalRepositoryImpl(
      this.localFloorDatasource, this.localWebServiceDatasource);

  @override
  Future<Either<Failure, bool>> deleteAllLocal() async {
    return await localFloorDatasource.deleteAllLocal();
  }

  @override
  Future<Either<Failure, List<Local>>> recoverAllLocal(String token) async {
    try {
      final result = await localWebServiceDatasource.getAllLocal(token);
      return Right(
          result.map((e) => Local.fromWebServiceModelToEntity(e)).toList());
    } on ErrorWebServiceDatasource catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ErrorRepository("recoverAllLocal =>  ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, bool>> addAllLocal(List<Local> list) async {
    try {
      return await localFloorDatasource.addAllLocal(list.map((e) => LocalFloorModel.fromEntityToFloorModel(e)).toList());
    } on ErrorFloorDatasource catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ErrorRepository("addAllLocal =>  ${e.toString()}"));
    }
  }
}
