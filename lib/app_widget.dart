import 'package:flutter/material.dart';
import 'package:pcp/app_style.dart';
import 'package:pcp/app_router.dart';

class AppWidget extends StatelessWidget {
  final String urlInitial;
  const AppWidget({super.key, this.urlInitial = "/"});

  @override
  Widget build(BuildContext context) {
    AppTheme style = AppTheme();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'PCP',
      theme: style.appStyle,
      routerConfig: router(urlInitial),
    );
  }
}
