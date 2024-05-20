import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pcp/app_module.dart';
import 'package:pcp/app_style.dart';
import 'package:pcp/external/floor/app_database.dart';
import 'package:pcp/utils/constant.dart';

import '../../../external/floor/dao/colab_dao.dart';

const KEY_APONT_MENU_INICIAL_ITEM = 'key_apont_menu_inicial_item';
const KEY_CONFIG_MENU_INICIAL_ITEM = 'key_config_menu_inicial_item';
const KEY_SAIR_MENU_INICIAL_ITEM = 'key_sair_menu_inicial_item';

class MenuInicialPage extends StatefulWidget {
  const MenuInicialPage({super.key});

  @override
  State<MenuInicialPage> createState() => _MenuInicialPageState();
}

class _MenuInicialPageState extends State<MenuInicialPage> {
  AppTheme style = AppTheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      onTap: () async => db(),
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
    );
  }
}

void db() async {
  // print("Rodou");
  // final database = getIt<AppDatabase>();
  // final dao = database.colabDao;
  // dao.deleteAll();
  // dao.insert(ColabFloorModel(
  //   matricColab: 100,
  //   nomeColab: "Anderson da Silva Delgado",
  // ));
  // print("Salvou");
}
