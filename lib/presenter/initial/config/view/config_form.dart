import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pcp/app_style.dart';
import 'package:pcp/domain/errors/errors.dart';
import 'package:pcp/presenter/initial/config/cubit/config_cubit.dart';
import 'package:pcp/presenter/initial/config/cubit/config_states.dart';
import 'package:pcp/utils/activity_extension.dart';
import 'package:pcp/utils/constant.dart';
import 'package:pcp/utils/calc.dart';

const KEY_NRO_APARELHO_CONFIG_TEXT_FIELD = 'key_nro_aparelho_config_text_field';
const KEY_SENHA_CONFIG_TEXT_FIELD = 'key_senha_config_text_field';
const KEY_OK_CONFIG_BUTTON = 'key_ok_config_button';
const KEY_CANCELAR_CONFIG_BUTTON = 'key_cancelar_config_button';
const KEY_ATUALIZAR_BD_CONFIG_BUTTON = 'key_atualizar_bd_config_button';
const KEY_MSG_TEXT = 'key_msg_text';

class ConfigForm extends StatefulWidget {
  const ConfigForm({super.key});

  @override
  State<ConfigForm> createState() => _ConfigFormState();
}

class _ConfigFormState extends State<ConfigForm>
    with SingleTickerProviderStateMixin {
  AppTheme style = AppTheme();
  final TextEditingController _nroAparelhoController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'CONFIGURAÇÃO',
            style: style.titleDefaultTextStyle,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocListener<ConfigCubit, ConfigStates>(
              listener: (BuildContext context, ConfigStates state) {
                if (state is FinishConfigStates) {
                  showDialogDefaultFunction(
                      context,
                      "Finalização de Configurações Iniciais",
                      ReadContext(context)
                          .read<ConfigCubit>()
                          .updateAllDatabase());
                }
                if (state is FinishConfigStates) {
                  showDialogDefault(
                      context, "Finalização de Configurações Iniciais");
                }
              },
              child: Column(
                children: [
                  Padding(
                    padding: style.textFieldMarginDefault,
                    child: TextField(
                      key: const Key(KEY_NRO_APARELHO_CONFIG_TEXT_FIELD),
                      controller: _nroAparelhoController,
                      style: style.textFieldTextStyle,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        labelText: 'NRO APARELHO',
                        labelStyle: style.textFieldTextStyle,
                        border: const OutlineInputBorder(),
                      ),
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
                              if (_nroAparelhoController.text.isEmpty ||
                                  _senhaController.text.isEmpty) {
                                showDialogDefault(context,
                                    "CAMPO VAZIO! POR FAVOR, PREENCHA TODOS OS CAMPOS PARA SALVAR AS CONFIGURAÇÕES.");
                              } else {
                                ReadContext(context)
                                    .read<ConfigCubit>()
                                    .saveConfig(
                                      password: _senhaController.text,
                                      nroAparelho: _nroAparelhoController.text,
                                      version: "5.0",
                                    );
                              }
                            },
                            style: ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                  style.buttonMarginDefault),
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
                            key: const Key(KEY_CANCELAR_CONFIG_BUTTON),
                            style: ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                  style.buttonMarginDefault),
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
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => {},
                            key: const Key(KEY_ATUALIZAR_BD_CONFIG_BUTTON),
                            style: ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                  style.buttonMarginDefault),
                            ),
                            child: Text(
                              'ATUALIZAR DADOS',
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
            BlocBuilder<ConfigCubit, ConfigStates>(
              builder: (context, state) {
                const int sizeInitialConfig = 3;
                const int sizeUpdateDatabase = 15;
                if (state is InitialConfigStates) {
                  return const Column();
                } else if (state is SendConfigStates) {
                  return _progress(
                      porc(1, sizeInitialConfig), "Enviar Dados de Token");
                } else if (state is SaveConfigStates) {
                  return _progress(porc(2, sizeInitialConfig),
                      "Salvar Dados de Configurações");
                } else if (state is FinishConfigStates) {
                  return _progress(porc(3, sizeInitialConfig),
                      "Finalizando Configurações Inicial");
                } else if (state is DeleteTableStates) {
                  return _progress(porc((state.pos + 1), sizeUpdateDatabase),
                      "Excluindo dados da tabela '${state.table}'");
                } else if (state is RecoverDataTableStates) {
                  return _progress(porc((state.pos + 2), sizeUpdateDatabase),
                      "Importando dados da tabela '${state.table}' do web service");
                } else if (state is AddDataTableStates) {
                  return _progress(porc((state.pos + 3), sizeUpdateDatabase),
                      "Salvandos dados da tabela '${state.table}' do web service");
                } else if (state is ErrorConfigStates) {
                  final ErrorConfigStates error = state;
                  final failure = error.failure;
                  if (failure is ErrorRepository) {
                    final ErrorRepository integrationData = failure;
                    return _progress(
                        1, "Error Repository => ${integrationData.message!}");
                  } else if (failure is ErrorWebServiceDatasource) {
                    final ErrorWebServiceDatasource errorWebServiceDatasource =
                        failure;
                    return _progress(1,
                        "Error Web Service Datasource => ${errorWebServiceDatasource.message!}");
                  } else if (failure is ErrorFloorDatasource) {
                    final ErrorFloorDatasource errorFloorDatasource = failure;
                    return _progress(1,
                        "Error Floor Datasource => ${errorFloorDatasource.message!}");
                  } else {
                    return _progress(
                        1, "Falha inexistente tipo 1. Contate o TI");
                  }
                } else {
                  return _progress(1, "Falha inexistente tipo 2. Contate o TI");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _progress(double progressValue, String descriptionValue) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Padding(
            padding: style.textFieldMarginDefault,
            child: LinearProgressIndicator(
              minHeight: 40.0,
              value: progressValue,
            ),
          ),
          Padding(
            padding: style.textFieldMarginDefault,
            child: Text(
              key: const Key(KEY_MSG_TEXT),
              descriptionValue,
              style: style.textFieldTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
