import 'package:floor/floor.dart';
import 'package:pcp/infra/model/floor/stable/visitante_floor_model.dart';
import 'package:pcp/utils/constant.dart';

@dao
abstract class VisitanteDao {

  @Query('DELETE FROM $TABLE_FLOOR_VISITANTE')
  Future<void> deleteAll();

  @insert
  Future<List<int>> insertAll(List<VisitanteFloorModel> listVisitante);
}