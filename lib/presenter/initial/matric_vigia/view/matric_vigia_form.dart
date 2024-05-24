import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pcp/app_style.dart';
import 'package:pcp/presenter/initial/matric_vigia/cubit/matric_vigia_cubit.dart';
import 'package:pcp/presenter/initial/matric_vigia/cubit/matric_vigia_states.dart';
import 'package:pcp/utils/activity_extension.dart';
import 'package:pcp/utils/enum.dart';

class MatricVigiaForm extends StatefulWidget {
  const MatricVigiaForm({super.key});

  @override
  State<MatricVigiaForm> createState() => _MatricVigiaFormState();
}

const KEY_MATRIC_VIGIA_TEXT_FIELD = 'key_matric_vigia_text_field';

class _MatricVigiaFormState extends State<MatricVigiaForm> {
  AppTheme style = AppTheme();
  final TextEditingController matricVigiaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MatricVigiaCubit, MatricVigiaStates>(
      listener: (BuildContext context, MatricVigiaStates state) {},
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'VIGIA',
              style: style.titleDefaultTextStyle,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: style.textFieldMarginDefault,
              child: TextField(
                key: const Key(KEY_MATRIC_VIGIA_TEXT_FIELD),
                controller: matricVigiaController,
                style: style.textFieldTextStyle,
                decoration: InputDecoration(
                  labelText: 'MATRIC. VIGIA',
                  labelStyle: style.textFieldTextStyle,
                  border: const OutlineInputBorder(),
                ),
                enableSuggestions: false,
                autocorrect: false,
                enableInteractiveSelection: false,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
            ),
            buildKeyboard(setTextField),
          ],
        ),
      ),
    );
  }

  void setTextField(String label, TypeButton type) {
    switch (type) {
      case TypeButton.NUMERIC:
        addTextField(matricVigiaController, label);
        break;
      case TypeButton.CLEAR:
        clearTextField(matricVigiaController);
        break;
      case TypeButton.OK:
        break;
      case TypeButton.UPDATE:
        break;
    }
  }
}
