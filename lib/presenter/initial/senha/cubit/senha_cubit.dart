import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pcp/domain/usecases/initial/check_password_config.dart';
import 'package:pcp/presenter/initial/senha/cubit/senha_states.dart';

class SenhaCubit extends Cubit<SenhaStates> {
  final CheckPasswordConfig checkPasswordConfig;
  SenhaCubit(this.checkPasswordConfig) : super(InitialSenhaStates());

  Future<void> checkPassword(String password) async {
    final result = await checkPasswordConfig(password);
    if(result){
      emit(SuccessSenhaStates());
    } else {
      emit(FailSenhaStates());
    }
  }

}