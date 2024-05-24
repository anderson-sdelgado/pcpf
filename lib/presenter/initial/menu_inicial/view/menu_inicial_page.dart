import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/presenter/initial/menu_inicial/cubit/menu_inicial_cubit.dart';
import 'package:pcp/presenter/initial/menu_inicial/view/menu_inicial_form.dart';

class MenuInicialPage extends StatelessWidget {
  const MenuInicialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MenuInicialCubit>(),
      child: const MenuInicialForm(),
    );
  }
}