import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pcp/app_style.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppTheme style = AppTheme();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'PCP',
      theme: style.appStyle,
      routerConfig: Modular.routerConfig,
    );
  }
}
