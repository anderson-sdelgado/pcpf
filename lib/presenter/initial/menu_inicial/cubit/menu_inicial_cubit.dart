import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pcp/domain/usecases/initial/check_status_update_database.dart';
import 'package:pcp/presenter/initial/menu_inicial/cubit/menu_inicial_states.dart';

class MenuInicialCubit extends Cubit<MenuInicialStates> {
  final CheckStatusUpdateDatabase checkStatusUpdateDatabase;
  MenuInicialCubit(this.checkStatusUpdateDatabase) : super(InitialMenuInicialStates());

  Future<void> checkAccessApont() async {
    final result = await checkStatusUpdateDatabase();
    if(result){
      emit(AccessGrantedMenuInicialStates());
    } else {
      emit(AccessDeniedMenuInicialStates());
    }
  }

}