import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/presenter/initial/matric_vigia/cubit/matric_vigia_cubit.dart';
import 'package:pcp/presenter/initial/matric_vigia/view/matric_vigia_form.dart';

class MatricVigiaPage extends StatelessWidget {
  const MatricVigiaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MatricVigiaCubit>(),
      child: const MatricVigiaForm(),
    );
  }
}
