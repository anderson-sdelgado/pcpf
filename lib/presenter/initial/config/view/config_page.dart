import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/presenter/initial/config/cubit/config_cubit.dart';
import 'package:pcp/presenter/initial/config/view/config_form.dart';

// ignore: must_be_immutable
class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ConfigCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<ConfigCubit>(),
        ),
      ],
      child: const ConfigForm(),
    );
  }
}
