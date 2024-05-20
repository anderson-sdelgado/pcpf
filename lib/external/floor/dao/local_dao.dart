import 'package:floor/floor.dart';
import 'package:pcp/infra/model/floor/stable/local_floor_model.dart';
import 'package:pcp/utils/constant.dart';

@dao
abstract class LocalDao {

  @Query('DELETE FROM $TABLE_FLOOR_LOCAL')
  Future<void> deleteAll();

  @insert
  Future<List<int>> insertAll(List<LocalFloorModel> listLocal);
}