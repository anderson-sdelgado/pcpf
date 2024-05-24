import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/presenter/initial/senha/cubit/senha_cubit.dart';
import 'package:pcp/presenter/initial/senha/view/senha_form.dart';

// ignore: must_be_immutable
class SenhaPage extends StatelessWidget {
  const SenhaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SenhaCubit>(),
      child: const SenhaForm(),
    );
  }
}
