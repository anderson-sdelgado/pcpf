import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/stable/terceiro.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/stable/terceiro_repository.dart';
import 'package:pcp/infra/datasource/floor/stable/terceiro_floor_datasource.dart';
import 'package:pcp/infra/datasource/web_preferences/stable/terceiro_web_service_datasource.dart';
import 'package:pcp/infra/model/floor/stable/terceiro_floor_model.dart';

class TerceiroRepositoryImpl implements TerceiroRepository {
  TerceiroFloorDatasource terceiroFloorDatasource;
  TerceiroWebServiceDatasource terceiroWebServiceDatasource;

  TerceiroRepositoryImpl(
      this.terceiroFloorDatasource, this.terceiroWebServiceDatasource);

  @override
  Future<Either<Failure, bool>> deleteAllTerceiro() async {
    return await terceiroFloorDatasource.deleteAllTerceiro();
  }

  @override
  Future<Either<Failure, List<Terceiro>>> recoverAllTerceiro(String token) async {
    try {
      final result = await terceiroWebServiceDatasource.getAllTerceiro(token);
      return Right(
          result.map((e) => Terceiro.fromWebServiceModelToEntity(e)).toList());
    } on ErrorWebServiceDatasource catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ErrorRepository("recoverAllTerceiro =>  ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, bool>> addAllTerceiro(List<Terceiro> list) async {
    try {
      return await terceiroFloorDatasource.addAllTerceiro(list.map((e) => TerceiroFloorModel.fromEntityToFloorModel(e)).toList());
    } on ErrorFloorDatasource catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ErrorRepository("addAllTerceiro =>  ${e.toString()}"));
    }
  }
}
