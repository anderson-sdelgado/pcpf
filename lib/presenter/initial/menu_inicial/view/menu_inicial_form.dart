import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pcp/app_style.dart';
import 'package:pcp/presenter/initial/menu_inicial/cubit/menu_inicial_cubit.dart';
import 'package:pcp/presenter/initial/menu_inicial/cubit/menu_inicial_states.dart';
import 'package:pcp/utils/activity_extension.dart';
import 'package:pcp/utils/constant.dart';

const KEY_APONT_MENU_INICIAL_ITEM = 'key_apont_menu_inicial_item';
const KEY_CONFIG_MENU_INICIAL_ITEM = 'key_config_menu_inicial_item';
const KEY_SAIR_MENU_INICIAL_ITEM = 'key_sair_menu_inicial_item';

class MenuInicialForm extends StatefulWidget {
  const MenuInicialForm({super.key});

  @override
  State<MenuInicialForm> createState() => _MenuInicialFormState();
}

class _MenuInicialFormState extends State<MenuInicialForm> {
  AppTheme style = AppTheme();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MenuInicialCubit, MenuInicialStates>(
      listener: (BuildContext context, MenuInicialStates state) {
        if (state is AccessGrantedMenuInicialStates) {
          context.go(URL_MATRIC_VIGIA);
        } else if (state is AccessDeniedMenuInicialStates) {
          showDialogDefault(context, "POR FAVOR, CONFIGURE O APLICATIVO ANTES DE COMEÇAR O APONTAMENTO!");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'MENU INICIAL',
              style: style.titleDefaultTextStyle,
            ),
          ),
        ),
        body: Padding(
          padding: style.themeMarginDefault,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          key: const Key(KEY_APONT_MENU_INICIAL_ITEM),
                          'APONTAMENTO',
                          style: style.itemListTextStyle,
                        ),
                        onTap: () {
                          ReadContext(context)
                              .read<MenuInicialCubit>()
                              .checkAccessApont();
                        },
                      ),
                      ListTile(
                        title: Text(
                          key: const Key(KEY_CONFIG_MENU_INICIAL_ITEM),
                          'CONFIGURAÇÃO',
                          style: style.itemListTextStyle,
                        ),
                        onTap: () => context.go(URL_SENHA),
                      ),
                      ListTile(
                        title: Text(
                          key: const Key(KEY_SAIR_MENU_INICIAL_ITEM),
                          'SAIR',
                          style: style.itemListTextStyle,
                        ),
                        onTap: () => SystemNavigator.pop(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
