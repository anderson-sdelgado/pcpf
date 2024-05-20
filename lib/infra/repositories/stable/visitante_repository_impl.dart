import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/stable/visitante.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/stable/visitante_repository.dart';
import 'package:pcp/infra/datasource/floor/stable/visitante_floor_datasource.dart';
import 'package:pcp/infra/datasource/web_preferences/stable/visitante_web_service_datasource.dart';
import 'package:pcp/infra/model/floor/stable/visitante_floor_model.dart';

class VisitanteRepositoryImpl implements VisitanteRepository {
  VisitanteFloorDatasource visitanteFloorDatasource;
  VisitanteWebServiceDatasource visitanteWebServiceDatasource;

  VisitanteRepositoryImpl(
      this.visitanteFloorDatasource, this.visitanteWebServiceDatasource);

  @override
  Future<Either<Failure, bool>> deleteAllVisitante() async {
    return await visitanteFloorDatasource.deleteAllVisitante();
  }

  @override
  Future<Either<Failure, List<Visitante>>> recoverAllVisitante(String token) async {
    try {
      final result = await visitanteWebServiceDatasource.getAllVisitante(token);
      return Right(
          result.map((e) => Visitante.fromWebServiceModelToEntity(e)).toList());
    } on ErrorWebServiceDatasource catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ErrorRepository("recoverAllVisitante =>  ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, bool>> addAllVisitante(List<Visitante> list) async {
    try {
      return await visitanteFloorDatasource.addAllVisitante(list.map((e) => VisitanteFloorModel.fromEntityToFloorModel(e)).toList());
    } on ErrorFloorDatasource catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ErrorRepository("addAllVisitante =>  ${e.toString()}"));
    }
  }
}
