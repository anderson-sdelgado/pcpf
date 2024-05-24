import 'package:dartz/dartz.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/external/floor/app_database.dart';
import 'package:pcp/infra/datasource/floor/stable/equip_floor_datasource.dart';
import 'package:pcp/infra/model/floor/stable/equip_floor_model.dart';

class EquipFloorDatasourceImpl implements EquipFloorDatasource {
  final AppDatabase appDatabase;
  EquipFloorDatasourceImpl(this.appDatabase);

  @override
  Future<Either<Failure, bool>> deleteAllEquip() async {
    try {
      final dao = appDatabase.equipDao;
      await dao.deleteAll();
      return const Right(true);
    } catch (ex) {
      return Left(ErrorFloorDatasource(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> addAllEquip(List<EquipFloorModel> list) async {
    try {
      final dao = appDatabase.equipDao;
      var result = await dao.insertAll(list);
      if (list.length == result.length) {
        return const Right(true);
      } else {
        return Left(ErrorFloorDatasource("Invalid insert count"));
      }
    } catch (ex) {
      return Left(ErrorFloorDatasource(ex.toString()));
    }
  }
}
