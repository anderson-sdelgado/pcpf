import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pcp/domain/usecases/initial/check_password_config.dart';
import 'package:pcp/presenter/initial/senha/cubit/senha_states.dart';

class SenhaCubit extends Cubit<SenhaStates> {
  final CheckPasswordConfig checkPasswordConfig;
  SenhaCubit(this.checkPasswordConfig) : super(InitialSenhaStates());

  Future<void> checkPassword(String password) async {
    var ret = await checkPasswordConfig(password);
    log("Chegou aki 1");
    if(ret){
      emit(SuccessSenhaStates());
    } else {
      emit(FailSenhaStates());
    }
  }

}