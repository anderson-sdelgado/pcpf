import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pcp/presenter/initial/config/view/config_page.dart';
import 'package:pcp/presenter/initial/matric_vigia/view/matric_vigia_page.dart';
import 'package:pcp/presenter/initial/menu_inicial/view/menu_inicial_page.dart';
import 'package:pcp/presenter/initial/senha/view/senha_page.dart';
import 'package:pcp/utils/constant.dart';

router(String urlInitial) => GoRouter(
  initialLocation: urlInitial,
  routes: <RouteBase>[
    GoRoute(
      path: URL_MENU_INICIAL,
      builder: (BuildContext context, GoRouterState state) {
        return const MenuInicialPage();
      },
    ),
    GoRoute(
      path: URL_SENHA,
      builder: (BuildContext context, GoRouterState state) {
        return const SenhaPage();
      },
    ),
    GoRoute(
      path: URL_CONFIG,
      builder: (BuildContext context, GoRouterState state) {
        return const ConfigPage();
      },
    ),
    GoRoute(
      path: URL_MATRIC_VIGIA,
      builder: (BuildContext context, GoRouterState state) {
        return const MatricVigiaPage();
      },
    ),
  ],
);