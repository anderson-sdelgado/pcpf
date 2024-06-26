import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pcp/app_style.dart';
import 'package:pcp/presenter/initial/senha/cubit/senha_cubit.dart';
import 'package:pcp/presenter/initial/senha/cubit/senha_states.dart';
import 'package:pcp/utils/activity_extension.dart';
import 'package:pcp/utils/constant.dart';

const KEY_SENHA_TEXT_FIELD = 'key_senha_text_field';
const KEY_OK_SENHA_BUTTON = 'key_ok_senha_button';
const KEY_CANCELAR_SENHA_BUTTON = 'key_cancelar_senha_button';

class SenhaForm extends StatefulWidget {
  const SenhaForm({super.key});

  @override
  State<SenhaForm> createState() => _SenhaFormState();
}

class _SenhaFormState extends State<SenhaForm> {
  AppTheme style = AppTheme();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SenhaCubit, SenhaStates>(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'SENHA',
              style: style.titleDefaultTextStyle,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: style.textFieldMarginDefault,
              child: TextField(
                key: const Key(KEY_SENHA_TEXT_FIELD),
                controller: _senhaController,
                style: style.textFieldTextStyle,
                decoration: InputDecoration(
                  labelText: 'SENHA',
                  labelStyle: style.textFieldTextStyle,
                  border: const OutlineInputBorder(),
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
            ),
            Padding(
              padding: style.themeMarginDefault,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      key: const Key(KEY_OK_SENHA_BUTTON),
                      onPressed: () {
                        ReadContext(context)
                            .read<SenhaCubit>()
                            .checkPassword(_senhaController.text);
                      },
                      style: ButtonStyle(
                        padding:
                            MaterialStatePropertyAll(style.buttonMarginDefault),
                      ),
                      child: Text(
                        'OK',
                        style: style.textFieldTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => context.go(URL_MENU_INICIAL),
                      key: const Key(KEY_CANCELAR_SENHA_BUTTON),
                      style: ButtonStyle(
                        padding:
                            MaterialStatePropertyAll(style.buttonMarginDefault),
                      ),
                      child: Text(
                        'CANCELAR',
                        style: style.textFieldTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      listener: (context, state) {
        if (state is SuccessSenhaStates) {
          context.go(URL_CONFIG);
        } else if (state is FailSenhaStates) {
          showDialogDefault(context, "SENHA INVÁLIDA!");
        }
      },
    );
  }
}
