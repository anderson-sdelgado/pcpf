import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pcp/presenter/initial/matric_vigia/cubit/matric_vigia_states.dart';

class MatricVigiaCubit extends Cubit<MatricVigiaStates> {
  MatricVigiaCubit() : super(InitialMatricVigiaStates());

}