import 'package:floor/floor.dart';
import 'package:pcp/infra/model/floor/stable/colab_floor_model.dart';
import 'package:pcp/utils/constant.dart';

@dao
abstract class ColabDao {

  @Query('DELETE FROM $TABLE_FLOOR_COLAB')
  Future<void> deleteAll();

  @insert
  Future<List<int>> insertAll(List<ColabFloorModel> listColab);
}