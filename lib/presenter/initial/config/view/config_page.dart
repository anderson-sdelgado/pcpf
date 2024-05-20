import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/app_style.dart';
import 'package:pcp/presenter/initial/config/cubit/config_cubit.dart';
import 'package:pcp/presenter/initial/config/cubit/config_states.dart';
import 'package:pcp/presenter/initial/config/view/config_form.dart';
import 'package:pcp/utils/activity_extension.dart';
import 'package:pcp/utils/constant.dart';

class ConfigPage extends StatelessWidget {
  ConfigPage({super.key});

  AppTheme style = AppTheme();

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
