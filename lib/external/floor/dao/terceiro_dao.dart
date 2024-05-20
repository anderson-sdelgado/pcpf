import 'package:floor/floor.dart';
import 'package:pcp/infra/model/floor/stable/terceiro_floor_model.dart';
import 'package:pcp/utils/constant.dart';

@dao
abstract class TerceiroDao {

  @Query('DELETE FROM $TABLE_FLOOR_TERCEIRO')
  Future<void> deleteAll();

  @insert
  Future<List<int>> insertAll(List<TerceiroFloorModel> listTerceiro);
}