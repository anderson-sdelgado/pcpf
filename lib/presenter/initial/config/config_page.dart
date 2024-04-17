import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pcp/app_style.dart';
import 'package:pcp/utils/activity_extension.dart';
import 'package:pcp/utils/constant.dart';

const KEY_NRO_APARELHO_CONFIG_TEXT_FIELD = 'key_nro_aparelho_config_text_field';
const KEY_SENHA_CONFIG_TEXT_FIELD = 'key_senha_config_text_field';
const KEY_OK_CONFIG_BUTTON = 'key_ok_config_button';
const KEY_CANCELAR_CONFIG_BUTTON = 'key_cancelar_config_button';
const KEY_ATUALIZAR_BD_CONFIG_BUTTON = 'key_atualizar_bd_config_button';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage>{
  AppTheme style = AppTheme();
  final TextEditingController _nroAparelhoController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'CONFIGURAÇÕES',
            style: style.titleDefaultTextStyle,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: style.textFieldMarginDefault,
            child: TextField(
              key: const Key(KEY_NRO_APARELHO_CONFIG_TEXT_FIELD),
              controller: _nroAparelhoController,
              style: style.textFieldTextStyle,
              decoration: InputDecoration(
                labelText: 'NRO APARELHO',
                labelStyle: style.textFieldTextStyle,
                border: const OutlineInputBorder(),
              ),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
          ),
          Padding(
            padding: style.textFieldMarginDefault,
            child: TextField(
              key: const Key(KEY_SENHA_CONFIG_TEXT_FIELD),
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
                    key: const Key(KEY_OK_CONFIG_BUTTON),
                    onPressed: () {
                      if(_nroAparelhoController.text.isEmpty || _senhaController.text.isEmpty){
                        showDialogDefault(context, "CAMPO VAZIO! POR FAVOR, PREENCHA TODOS OS CAMPOS PARA SALVAR AS CONFIGURAÇÕES.");
                      }
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
                    onPressed: () => Modular.to.navigate(URL_MENU_INICIAL),
                    key: const Key(KEY_CANCELAR_CONFIG_BUTTON),
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
          Padding(
            padding: style.textFieldMarginDefault,
            child: ElevatedButton(
              onPressed: () => {},
              key: const Key(KEY_ATUALIZAR_BD_CONFIG_BUTTON),
              style: ButtonStyle(
                padding:
                MaterialStatePropertyAll(style.buttonMarginDefault),
              ),
              child: Text(
                'ATUALIZAR DADOS',
                style: style.textFieldTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
