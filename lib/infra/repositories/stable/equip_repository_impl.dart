import 'package:dartz/dartz.dart';
import 'package:pcp/domain/entities/stable/equip.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/domain/repositories/stable/equip_repository.dart';
import 'package:pcp/infra/datasource/floor/stable/equip_floor_datasource.dart';
import 'package:pcp/infra/datasource/web_preferences/stable/equip_web_service_datasource.dart';
import 'package:pcp/infra/model/floor/stable/equip_floor_model.dart';

class EquipRepositoryImpl implements EquipRepository {
  EquipFloorDatasource equipFloorDatasource;
  EquipWebServiceDatasource equipWebServiceDatasource;

  EquipRepositoryImpl(
      this.equipFloorDatasource, this.equipWebServiceDatasource);

  @override
  Future<Either<Failure, bool>> deleteAllEquip() async {
    return await equipFloorDatasource.deleteAllEquip();
  }

  @override
  Future<Either<Failure, List<Equip>>> recoverAllEquip(String token) async {
    try {
      final result = await equipWebServiceDatasource.getAllEquip(token);
      return Right(
          result.map((e) => Equip.fromWebServiceModelToEntity(e)).toList());
    } on ErrorWebServiceDatasource catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ErrorRepository("recoverAllEquip =>  ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, bool>> addAllEquip(List<Equip> list) async {
    try {
      return await equipFloorDatasource.addAllEquip(list.map((e) => EquipFloorModel.fromEntityToFloorModel(e)).toList());
    } on ErrorFloorDatasource catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ErrorRepository("addAllEquip =>  ${e.toString()}"));
    }
  }
}
