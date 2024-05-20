import 'package:floor/floor.dart';
import 'package:pcp/infra/model/floor/stable/equip_floor_model.dart';
import 'package:pcp/utils/constant.dart';

@dao
abstract class EquipDao {

  @Query('DELETE FROM $TABLE_FLOOR_EQUIP')
  Future<void> deleteAll();

  @insert
  Future<List<int>> insertAll(List<EquipFloorModel> listEquip);
}